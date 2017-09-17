#!/bin/bash

deleted_stats=".preread, .pids_stats, .num_procs, .storage_stats, .precpu_stats"

fetch_stats() {
  echo -e "GET /containers/$1/stats?stream=0 HTTP/1.0\r\n" |
    nc -q 2 -U /docker.sock |
    tail -n 1 |
    jq -c "del($deleted_stats)"
}

fetch_containers() {
  echo -e "GET /containers/json HTTP/1.0\r\n" |
    nc -U /docker.sock |
    tail -n 1 |
    jq -r "map(.Id[0:12]) | .[]"
}

: ${SCAN_INTERVAL:=60}
while true; do
  fetch_containers | while read container_id; do
    echo "$(fetch_stats $container_id)"
  done

  sleep $SCAN_INTERVAL
done
