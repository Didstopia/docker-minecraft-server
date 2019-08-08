# Minecraft Server for Docker

Latest supported/tested version: **1.14.4** (automatic updates is a planned feature)

**DISCLAIMER**: By default, this image automatically agrees to the Minecraft Server EULA, so by running this you are agreeing to it.

## How to run the server

1. Modify the environment variables to specify memory usage etc.
2. Mount `/app` on the host
3. Start and stop the server, then modify `/app/server.properties` and start it again

The following environment variables are available:

```text
MINECRAFT_SERVER_MEMORY_MIN   (DEFAULT: "1G" - Sets the minimum amount of memory to be used)
MINECRAFT_SERVER_MEMORY_MAX   (DEFAULT: "1G" - Sets the maximum amount of memory to be used)
MINECRAFT_SERVER_AGREE_EULA   (DEFAULT: "true" - Automatically agrees to the EULA)
MINECRAFT_SERVER_ARGUMENTS    (DEFAULT: "nogui" - Sets the startup parameters for Minecraft Server)
MINECRAFT_SERVER_CUSTOM_JAR   (DEFAULT: <none> - Sets a custom .jar file to run, useful for Forge etc.)
```

If you need help, have questions or bug submissions, feel free to contact me **@Dids** on Twitter or post an issue here on GitHub.
