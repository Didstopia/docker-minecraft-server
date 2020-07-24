# Minecraft Server for Docker

The server will attempt to download the latest server version on startup and update to it automatically.

**DISCLAIMER**: By default, this image automatically agrees to the Minecraft Server EULA, so by running this you are agreeing to it.

## How to run the server

1. Modify the environment variables to specify memory usage etc.
2. Mount `/app` on the host
3. Start and stop the server, then modify `/app/server.properties` and start it again

The following environment variables are available:

```text
MINECRAFT_SERVER_MEMORY_MIN    (DEFAULT: "1G"    - Sets the minimum amount of memory to be used)
MINECRAFT_SERVER_MEMORY_MAX    (DEFAULT: "1G"    - Sets the maximum amount of memory to be used)
MINECRAFT_SERVER_AGREE_EULA    (DEFAULT: "true"  - Automatically agrees to the EULA)
MINECRAFT_SERVER_ARGUMENTS     (DEFAULT: "nogui" - Sets the startup parameters for Minecraft Server)
MINECRAFT_SERVER_CUSTOM_JAR    (DEFAULT: <none>  - Sets a custom .jar file to run, useful for Forge etc.)
MINECRAFT_SERVER_RCON_ENABLE   (DEFAULT: "false" - Enables or disables RCON)
MINECRAFT_SERVER_RCON_PORT     (DEFAULT: "25575" - Sets the RCON port)
MINECRAFT_SERVER_RCON_PASSWORD (DEFAULT: ""      - Sets the RCON password)
```

## How to connect to the server remotely

Since [Minecraft support RCON](https://minecraft.gamepedia.com/Server.properties), we can easily use this to remotely control our server.

To enable RCON, there's only a few things we need to do first.
1. Make sure the RCON port (`25575`) is exposed or bound
2. Set the `MINECRAFT_SERVER_RCON_ENABLE` environment variable to `true`
3. Set the `MINECRAFT_SERVER_RCON_PASSWORD` environment variable to a secure password

Note that if this is the first time you're launching the server, you may need to restart the server once for RCON to function properly.  
This is simply because `server.properties` doesn't exist on the first launch, at least not until the server process has created it and RCON can't be enabled before it exists.

At this point you should be able to connect to the RCON service using any compatible RCON client.

---

If you need help, have questions or bug submissions, feel free to contact me **@Dids** on Twitter or post an issue here on GitHub.
