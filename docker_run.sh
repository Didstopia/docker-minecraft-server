#!/bin/bash

# Run the server
docker run -p 25565:25565 -m 4g -v $(pwd)/minecraft_data:/minecraft --name minecraft-server -d didstopia/minecraft-server:latest
docker logs -f minecraft-server
