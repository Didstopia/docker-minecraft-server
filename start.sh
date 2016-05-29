#!/usr/bin/env sh

# Copy the server in place
cp /minecraft_server.jar /minecraft/minecraft_server.jar

# Agree to the EULA
sed -i -e s/"eula=false"/"eula=true"/ /minecraft/eula.txt

# Create required files (if necessary)
touch /minecraft/banned-players.json
touch /minecraft/banned-ips.json
touch /minecraft/ops.json
touch /minecraft/whitelist.json

# Start the Minecraft server
echo "Starting server.."
_JAVA_OPTIONS=$MINECRAFT_STARTUP_ARGS
(cd /minecraft && exec java -jar /minecraft/minecraft_server.jar nogui)