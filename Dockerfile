FROM alpine:3.3

MAINTAINER Pauli Jokela <pauli.jokela@didstopia.com>

# System variables for use with installation
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=74 \
    JAVA_VERSION_BUILD=02 \
    JAVA_PACKAGE=server-jre \
    JAVA_HOME=/opt/jdk \
    PATH=${PATH}:/opt/jdk/bin \
    LANG=C.UTF-8

# Install dependencies
RUN apk —update upgrade && \
    apk --update add openjdk8-jre wget ca-certificates

# Install the latest Minecraft server
RUN wget --no-check-certificate https://s3.amazonaws.com/Minecraft.Download/versions/1.9.4/minecraft_server.1.9.4.jar -O /minecraft_server.jar
RUN chmod +x /minecraft_server.jar

# Copy the startup scripts (which also handles automatic updates)
ADD start.sh /start.sh
RUN chmod +x /start.sh

# Setup the environment variables
ENV MINECRAFT_STARTUP_ARGS "–Xmx1024M -Xms1024M"

# Set the volume
VOLUME ["/minecraft"]

# Expose the default server port
EXPOSE 25565

ENTRYPOINT ["/start.sh"]
