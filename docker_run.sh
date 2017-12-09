#!/bin/bash

# Make sure the image is up to date
./docker_build.sh

# Run the server
docker run -p 25565:25565 -m 4g -v $(pwd)/data:/app --name minecraft-server -it --rm didstopia/minecraft-server:latest

# Run a custom server
#docker run -p 25565:25565 -m 4g -v $(pwd)/data:/app -e MINECRAFT_SERVER_CUSTOM_JAR="some.jar" --name minecraft-server -it --rm didstopia/minecraft-server:latest
