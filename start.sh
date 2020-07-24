#!/bin/bash

# Enable error handling
set -e
set -o pipefail

# Enable debugging
# set -x

# The main startup function
function start()
{
    echo "Starting up.."

    # Check that we're not using a custom server
    if [ -z ${MINECRAFT_SERVER_CUSTOM_JAR+x} ]; then
      # Check for updates (updates /server.jar if any updates were found)
      checkForUpdates
    fi

    # Agree to EULA
    agreeToEULA

    # Start the server
    startServer
}

# A function that starts the server
function startServer()
{
  # Setup startup arguments for Java/Minecraft
  echo "Starting the server.."
  echo "Minimum server memory: ${MINECRAFT_SERVER_MEMORY_MIN}"
  echo "Maximum server memory: ${MINECRAFT_SERVER_MEMORY_MAX}"
  _JAVA_OPTIONS="${_JAVA_OPTIONS} -Xms${MINECRAFT_SERVER_MEMORY_MIN} -Xmx${MINECRAFT_SERVER_MEMORY_MAX}"

  # Switch to the server directory
  cd /app

  # Check that server.properties exists
  if [ -f "/app/server.properties" ]; then
    # Enable or disable RCON
    sed -i -r "s/^[#]*\s*enable-rcon=.*/enable-rcon=$MINECRAFT_SERVER_RCON_ENABLE/" server.properties

    # Set RCON port
    sed -i -r "s/^[#]*\s*rcon.port=.*/rcon.port=$MINECRAFT_SERVER_RCON_PORT/" server.properties

    # Set RCON password
    sed -i -r "s/^[#]*\s*rcon.password=.*/rcon.password=$MINECRAFT_SERVER_RCON_PASSWORD/" server.properties
  fi
  
  # Start the Minecraft server
  exec java -jar "/app/${MINECRAFT_SERVER_CUSTOM_JAR:=server.jar}" "${MINECRAFT_SERVER_ARGUMENTS}"
}

# A function that checks for server updates
function checkForUpdates()
{
  echo "Checking for updates.."

  # Download the latest server
  LATEST_SERVER_URL=$(curl -sL "$MINECRAFT_SERVER_DOWNLOAD_URL" | grep launcher.mojang | awk -F\" '{print $2}')
  wget --quiet --no-check-certificate "${LATEST_SERVER_URL}" -O "/tmp/server_latest.jar" > /dev/null

  # Make sure the current server path always exists
  if [ ! -f "/app/server.jar" ]; then
    cp -f /server.jar /app/server.jar
  fi

  # Get the hashes for the current and latest servers
  OLD_SERVER_HASH=($(md5sum /app/server.jar))
  NEW_SERVER_HASH=($(md5sum /tmp/server_latest.jar))

  # Compare the hashes to see if we need to update
  if [ ${OLD_SERVER_HASH} != ${NEW_SERVER_HASH} ]; then
    echo "Server update available, updating.."
      # Replace the current server with the latest one
      cp -f /tmp/server_latest.jar /app/server.jar
  else
    echo "No updates available, skipping.."
  fi
}

# A function that automatically agrees to the EULA
function agreeToEULA()
{
  if [[ ${MINECRAFT_SERVER_AGREE_EULA,,} == "true" ]]; then
    echo "Automatically agreeing to EULA.."
    EULA_FILE="/app/eula.txt"
    if [ ! -f "${EULA_FILE}" ]; then
      echo "eula=true" > "${EULA_FILE}"
    else
      if grep -q "eula=false" "${EULA_FILE}"; then
        sed -i -e s/"eula=false"/"eula=true"/ "${EULA_FILE}"
      fi
    fi
  fi
}

# Initiate the startup process
start
