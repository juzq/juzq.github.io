---
title: Gradle使用笔记
categories: [Development, Build]
tags: [Gradle]
---

## 安装gradle
1. 从官网下载gradle：<https://gradle.org/releases/>， 我一般选择`binary-only`版本
2. 解压到自己喜欢的目录
3. 添加bin目录到环境变量


## 升级gradle
`./gradlew wrapper --gradle-version=7.3.1`

## 创建gralde项目
`gradle init`，按照指引一步一步走下去即可。

参考：<https://docs.gradle.org/7.3.1/samples/sample_building_kotlin_applications.html#run_the_init_task>

## 子项目间共享构建逻辑

参考：<https://docs.gradle.org/7.3.1/samples/sample_convention_plugins.html>

## IDEA中gradle进程空闲超时时间
解决终止gradle任务后，由gradle启动的java进程未退出的问题。

Help -> Edit Custom Properties -> `external.system.remote.process.idle.ttl.ms=1000`

## 依赖本地项目
```kotlin
dependencies {
    implementation(project(":shared"))
}
```
其中，shared为项目名

## 为gradle启动的Java进程添加JVM参数
在*.gradle.kts中添加
```kotlin
plugins {
    ...
    application
}

application {
    applicationDefaultJvmArgs = listOf("-Ddev=true")
}
```


## 为kotlin的data class添加无参构造
1. 在build.gradle.kts中添加（只能是单个模块的build）
    ```kotlin
    plugins {
        ...
        id("org.jetbrains.kotli.plugin.noarg") version "1.5.31"
    }

    noArg {
        annotation("org.gamer.mxd.shared.common.NoArgConstructor")
        invokeInitializers = true
    }
    ```
    其中，annotation是对应注解的全名。（把id中的kotli改成kotlin，编辑器这里在抽风）
2. 创建注解类
    ```kotlin
    package org.gamer.mxd.shared.common

    @Target(AnnotationTarget.CLASS)
    @Retention(AnnotationRetention.SOURCE)
    annotation class NoArgConstructor
    ```
3. 在data class上面添加注解`@NoArgConstructor`，gradle就会在编译时自动添加无参构造。


## 仓库URL设置
在用户目录下创建文件夹`.gradle`，创建文件`init.gradle`，并输入以下内容：
```scala
allprojects{
    repositories {
        def ALIYUN_REPOSITORY_URL = 'https://maven.aliyun.com/repository/public/'
        def ALIYUN_JCENTER_URL = 'https://maven.aliyun.com/repository/jcenter/'
        def ALIYUN_GOOGLE_URL = 'https://maven.aliyun.com/repository/google/'
        def ALIYUN_GRADLE_PLUGIN_URL = 'https://maven.aliyun.com/repository/gradle-plugin/'
        all { ArtifactRepository repo ->
            if(repo instanceof MavenArtifactRepository){
                def url = repo.url.toString()
                if (url.startsWith('https://repo1.maven.org/maven2/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_REPOSITORY_URL."
                    remove repo
                }
                if (url.startsWith('https://jcenter.bintray.com/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_JCENTER_URL."
                    remove repo
                }
                if (url.startsWith('https://dl.google.com/dl/android/maven2/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_GOOGLE_URL."
                    remove repo
                }
                if (url.startsWith('https://plugins.gradle.org/m2/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_GRADLE_PLUGIN_URL."
                    remove repo
                }
            }
        }
        maven { url ALIYUN_REPOSITORY_URL }
        maven { url ALIYUN_JCENTER_URL }
        maven { url ALIYUN_GOOGLE_URL }
        maven { url ALIYUN_GRADLE_PLUGIN_URL }
    }
}
```