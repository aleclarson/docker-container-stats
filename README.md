
# docker-container-stats

Periodically prints the container stats (in JSON format) for each running container.

```sh
# Build the image from this repository.
docker build -t docker-container-stats https://github.com/aleclarson/docker-container-stats.git

# Start the container.
docker run -d -v /var/run/docker.sock:/docker.sock --restart=on-failure --name container.stats docker-container-stats
```

### Why would I need this?

You want to periodically send a JSON object of container stats to a logging service. This repository provides logging of container stats with minimal resource requirements. All that's left is forwarding the logs from Docker to your logging service, which isn't handled by this repository.

### Environment variables

- `SCAN_INTERVAL`: How long (in seconds) to wait before printing the container stats again (defaults to 60)

### Notes

- Containers are scanned 2 seconds apart, due to `netcat`'s connection with the Docker UNIX socket.

