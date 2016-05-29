FROM alpine:3.3

MAINTAINER Pauli Jokela <pauli.jokela@didstopia.com>

# Install dependencies
RUN apk --update add openjdk7-jre wget

# Install the latest Minecraft server
RUN wget --no-check-certificate https://s3.amazonaws.com/Minecraft.Download/versions/1.9.4/minecraft_server.1.9.4.jar -O /minecraft_server.jar
RUN chmod +x /minecraft_server.jar

# Copy the startup scripts (which also handles automatic updates)
ADD start.sh /start.sh
RUN chmod +x /start.sh

# Setup the environment variables
ENV MINECRAFT_STARTUP_ARGS "–Xmx1024M -Xms1024M"
ENV JVM_OPTS "-Djava.security.egd=file:/dev/urandom"

# Set the volume
VOLUME ["/minecraft"]

# Expose the default Minecraft server port
EXPOSE 25565

ENTRYPOINT ["/start.sh"]
