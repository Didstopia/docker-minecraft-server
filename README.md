# Minecraft server that runs inside a Docker container

**NOTE**: This container automatically agrees to the Minecraft server EULA, so by running this, you're also agreeing to it.

# How to run the server
1. Set the environment variables you wish to modify from below
2. Optionally mount ```/minecraft``` somewhere on the host or inside another container to keep your data safe
3. After launching the server once, modify ```/minecraft/server.properties``` to your liking

The following environment variables are available:
```
MINECRAFT_STARTUP_ARGS (DEFAULT: "–Xmx1024M -Xms1024M" - Sets the minimum and maximum amount of memory to be used)
MINECRAFT_EXTRA_STARTUP_ARGS (DEFAULT: "-Dcom.mojang.eula.agree=true -Djava.security.egd=file:/dev/urandom" - By default skips the EULA and produces better randomness on Docker)
```

If you need help, have questions or bug submissions, feel free to contact me **@Dids** on Twitter, and on the *Rust Server Owners* Slack community.
