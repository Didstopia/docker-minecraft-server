#!/bin/bash

set -e
set -o pipefail

docker tag didstopia/minecraft-server:latest didstopia/minecraft-server:latest
docker push didstopia/minecraft-server:latest
