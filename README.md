# The Fellowship's Minecraft Server Management Tools

## Starting the server

After everything is setup, you can simply type:

```
./run.sh
```

### Starting a new server checklist

1. Make sure your Linux user ID and group ID are both 1000 with the `id` shell command. This is the default for the first user created.
1. Create a directory with a memorable name ending in `_server_data`. For example: `fellowship_server_data`.
1. `LEVEL` must be set to the right minecraft level. For example: `LEVEL: fellowship` if you named the map "fellowship". If you don't have an existing map, the docker container will create it for you.
1. `volumes` must mount a host directory ending in `_server_data` to `/data` in the docker container. For example: `./fellowship_server_data:/data`.
1. The memory limit must be set to an appropriate value. For example: `MEMORY: "6G"` for 6 gigas of RAM.
1. Check the other environment variables and make sure they're correct. For example, `VERSION`.
1. Set the directory that must be backed up in `./run.sh`. For example: `SERVER_DATA=./fellowship_server_data`
1. Run `./run.sh`.
1. You should see the logs of docker-compose as it downloads stuff, and then the minecraft server logs.
1. Wait for the server to finish downloading everything and to start running successfully.
1. Gracefully shut down the server by running. See [Shutting down the server](#shutting-down-the-server).
1. Copy any worlds, mods, or datapacks into `plugins/`, `/mods`, `/datapacks`.
1. Run `./run.sh`.
1. Have fun!

### Shutting down the server

1. Either:
    - Press CTRL-C in the terminal that is running `./run.sh` or `docker-compose up` OR
    - Run `docker-compose down` in another terminal 
1. Wait to see the server's logs show `Stopping server`.
1. Wait until the container has exited.
1. **Only do this step after making sure the container has stopped.** If `docker-compose` itself fails to stop after this, run `killall docker-compose -9` to force kill docker compose.

### Improve server security

- If you have rcon enabled, please change the rcon password from the default "minecraft".
  Store the password in a secure file so the `rcon-cli.sh` script can read it without you having to place it in your shell history or always enter it manually (and make sure it never shows up in any files, besides encrypted ones).
- Do not expose rcon to the internet.
- Enable the server whitelist.
- Make sure that only necessary ports are:
    - allowed by the firewall
    - exposed to the internet (via port forwarding)

### Installing Dynmap

1. Download [Dynmap-3.3-beta-3-spigot.jar](https://media.forgecdn.net/files/3571/564/Dynmap-3.3-beta-3-spigot.jar) from [https://www.spigotmc.org/resources/dynmap%C2%AE.274/](https://www.spigotmc.org/resources/dynmap%C2%AE.274/)
1. Move file into your server data directory's `plugins/` directory.
1. Start minecraft server
1. Observe dynmap starting up in the logs
1. Run `/dynmap fullrender` command to start a full render.
1. Visit http://server-address:8123 to see the map!

### Too slow?

Try running Paper Minecraft by setting `TYPE: PAPER`.

If that's still too slow, use docker to just setup the server and then run the server on bare metal (without docker). You can still use the backup script.

## Scripts

| Filename | Purpose |
|----------|-------|
| `./scripts/backup.sh` | Compress the server data and copy it to a backup directory |
| `./scripts/rcon-cli.sh` | Start an RCON shell to send commands to the server |
| `./scripts/list-containers.sh` | Simply lists all running docker containers with `docker container ls`. You can use this to verify the server is running and healthy. |


## Useful tools

[read here](./useful_tools.md)
