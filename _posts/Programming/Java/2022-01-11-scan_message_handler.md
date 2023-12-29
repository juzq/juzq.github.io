---
title: 扫描消息处理类以更优雅的方式处理消息
categories: [Programming, Java]
tags: [Java]
---

## 目前处理消息的工作流程

1. 定义消息结构（如Protobuf的message结构）
2. **在cs.proto中定义接收消息号**
3. **在cs.proto中定义发送消息号**
4. 使用相关工具生成消息的Java代码
5. **在ChannelActor中添加该消息要转发到的服务器节点**
6. **在xxxHandlers中添加handler变量定义**
7. 在handler类中定义消息处理方法
8. **在xxxMessageMapping中添加消息与消息处理方法的映射**

## 流程分析
* 步骤过多，容易遗漏，尤其是需要转发到非home的消息。
* 加粗的步骤都是往同一个文件中加代码，特别容易冲突。
* 一个handler中写了多个消息的处理代码，容易让文件庞大，不利于定位和查找。

## 优化思路
* 将消息号直接定义在消息中，省去单独文件定义消息号，并且能减少冲突。
* 将消息处理节点也定义在消息中，Gate收到消息后能自动找到处理该消息的服务器节点，不用再添加代码，也减少了冲突。
* handler变量不在xxxHandlers中定义，直接实例化后丢到该节点的map中，需要处理时再从map中取出来，减少了代码也减少了冲突。
* 在定义handler时将消息类型作为泛型与该handler绑定，从而节省了添加消息与handler映射的步骤。
* 节点启动时扫描节点下的所有handler从而建立消息号与handler映射信息。
* Gate收到消息时，只解析出包头的消息号，不解析包体，直接将包体转发给对应节点，可以节省一次pb序列化与反序列化的性能。

## 具体实现
### 定义消息号与处理节点
```kotlin
@NodeMessage(node = NodeType.ACCOUNT, code = 0x01)
data class CSLogin(
    /** 帐号 */
    var account: String = "",
    /** 密码 */
    var password: String = "",
    
    ..
)
```
由于我使用的测试环境是某真实端游的客户端，其消息并未使用pb作为序列化组件，因此可以在定义消息时添加`@NodeMessage`注解。

若使用Protobuf时，可以采用如下格式定义：
```
message CSLogin {
    enum MessageInfo {
        ID = 1000;
        NODE = 1;
    }
    required string account = 1;
    required string password = 2;
}
message SCLogin {
    enum MessageInfo {
        ID = 1000;
    }
    required bool success = 1;
}
```
由于pb不支持给消息加注解，因此在每个消息体内定义了一个叫MessageInfo枚举，在这个枚举内定义了消息号和消息处理节点。

### Gate扫描消息类，缓存消息处理节点
```kotlin
fun scanCsMessagesNode() {
    val manager = GateNode.gateCodeManager
    val classList = scanPackages("$BASE_PACKAGE.shared.msg.client.v$VERSION")
    classList.forEach {
        val annotation = it.getAnnotation(NodeMessage::class.java)
        if (annotation != null) {
            val code = annotation.code
            manager.addCode(code, annotation.node)
            logger.debug("Gate register message node: ${shortHex(code)} -> ${annotation.node}")
        }
    }
}
```

### 各节点扫描消息处理类
```kotlin
fun scanCsMessageHandler(type: NodeType, codeHandlerMap: HashMap<Short, Pair<Class<out AbstractMapleMsg>, ClientMessageHandler<out AbstractBehavior<Any>, out AbstractMapleMsg>>>) {
    val classList = scanPackages("$BASE_PACKAGE.${type.name.lowercase()}")
    classList.forEach { clazz ->
        @Suppress("UNCHECKED_CAST")
        if (ClassUtils.checkInterface(clazz, ClientMessageHandler::class.java)) {
            val genericType = ClassUtils.getInterfaceGenericType(clazz, 0, 1) as Class<out AbstractMapleMsg>
            val annotation = requireNotNull(genericType.getAnnotation(NodeMessage::class.java))
            val code = annotation.code
            codeHandlerMap[code] = Pair(genericType, clazz.newInstance() as ClientMessageHandler<out AbstractBehavior<Any>, out AbstractMapleMsg>)
            logger.debug("Node register message handler: [${shortHex(code)}] ${genericType.name} -> ${clazz.name}")
        }
    }
}
```

## 开发步骤
1. 定义消息结构（如Protobuf的message结构）
2. 使用相关工具生成消息的Java代码
3. 定义消息处理类

## 例子
```kotlin
class AccountLogin : ClientMessageHandler<AccountActor, CSLogin> {

    override fun handle(actor: AccountActor, msg: CSLogin, context: MessageContext) {

        // TODO 帐号验证逻辑

        send(context, SCLoginFail(status = 4))
    }
}
```
在定义好消息类后，直接在对应的服务器节点模块上定义消息处理类即可。需要实现ClientMessageHandler接口，并提供Actor和消息类两个泛型，再重写handle方法即可。