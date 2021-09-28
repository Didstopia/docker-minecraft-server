FROM didstopia/base:alpine-3.12

LABEL maintainer="Didstopia <support@didstopia.com>"

# System variables for use with installation
ENV _JAVA_OPTIONS "-XX:+UseG1GC -Djava.security.egd=file:/dev/urandom"
ENV PATH "${PATH}:/opt/jdk/bin"
ENV LANG "C.UTF-8"

# Minecraft server specific environment variables
ENV MINECRAFT_SERVER_DOWNLOAD_URL "https://minecraft.net/en-us/download/server/"
ENV MINECRAFT_SERVER_MEMORY_MIN "1G"
ENV MINECRAFT_SERVER_MEMORY_MAX "1G"
ENV MINECRAFT_SERVER_AGREE_EULA "true"
ENV MINECRAFT_SERVER_ARGUMENTS "nogui"
ENV MINECRAFT_SERVER_RCON_ENABLE "false"
ENV MINECRAFT_SERVER_RCON_PORT "25575"
ENV MINECRAFT_SERVER_RCON_PASSWORD ""

# Install dependencies
RUN apk --no-cache add \
    openjdk8-jre \
    wget \
    ca-certificates \
    bash \
    curl

# Install the latest Minecraft server
RUN set -x; wget --quiet --no-check-certificate \
        "$(RANDVERSION=$(echo $((1 + $RANDOM % 4000))) curl -sL -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$RANDVERSION.212 Safari/537.36" "$MINECRAFT_SERVER_DOWNLOAD_URL" | grep launcher.mojang | awk -F\" '{print $2}')" \
        -O "/server.jar"
RUN chmod a+rwx /server.jar

# Copy the startup scripts (which also handles automatic updates)
ADD start.sh /start.sh
RUN chmod +x /start.sh

# Run as the "docker" user by default
ENV PGID 1000
ENV PUID 1000

# Expose the default server port
EXPOSE 25565

# Expose the default RCON port
EXPOSE 25575

# Export the default volume (already exported in base image, but QNAP doesn't detect this)
VOLUME ["/app"]

# Set the startup command
CMD ["/bin/bash", "/start.sh"]
