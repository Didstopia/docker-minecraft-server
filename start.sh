#!/bin/bash

set -e
set -o pipefail

function init()
{
    echo "Initializing.."

    # Install or update the server
    cp -u /minecraft_server.jar /app/minecraft_server.jar

    # Agree to EULA
    agreeToEULA

    # Start the server
    startServer
}

function startServer()
{
    # Setup startup arguments for Java/Minecraft
    echo "Minimum server memory: ${MINECRAFT_SERVER_MEMORY_MIN}"
    echo "Maximum server memory: ${MINECRAFT_SERVER_MEMORY_MAX}"
    echo ""
    _JAVA_OPTIONS="${_JAVA_OPTIONS} -Xms${MINECRAFT_SERVER_MEMORY_MIN} -Xmx${MINECRAFT_SERVER_MEMORY_MAX}"
    
    # Start the Minecraft server
    cd /app
    exec java -jar "/app/minecraft_server.jar" "${MINECRAFT_SERVER_ARGUMENTS}"
}

function agreeToEULA()
{
    if [[ ${MINECRAFT_SERVER_AGREE_EULA,,} == "true" ]]; then
        echo ""
        echo "Automatically agreeing to EULA.."
        echo ""
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
init
