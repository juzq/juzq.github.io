#!/bin/bash

cd "$(dirname "$0")"

container_id=629777eeb913

docker stop $container_id
docker start $container_id