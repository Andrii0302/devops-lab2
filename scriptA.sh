#!/bin/bash

# Define constants
IMAGE_NAME="andrii0302/lab_4diduk"
CONTAINERS=("srv1" "srv2" "srv3")
CPU_CORES=("0" "1" "2")

BUSY_LIMIT=50          # Percentage for busy state
IDLE_LIMIT=10          # Percentage for idle state
POLL_INTERVAL=10       # Check interval in seconds
STATE_COUNT=12          # Consecutive checks to confirm state
UPDATE_CHECK_INTERVAL=900  # Time interval for updates (15 minutes)

# Fetch CPU usage of a container
get_cpu_usage() {
    docker stats --no-stream --format "{{.CPUPerc}}" "$1" | tr -d '%' || echo "0"
}

# Update running containers with the latest image
refresh_containers() {
    echo "Performing container update..."
    docker pull "$IMAGE_NAME"

    for idx in ${!CONTAINERS[@]}; do
        container="${CONTAINERS[$idx]}"
        if docker ps --filter "name=$container" --format "{{.Names}}" | grep -q "$container"; then
            echo "Refreshing $container..."
            NEW_CONTAINER="${container}_new"
            docker run -d --name "$NEW_CONTAINER" --cpuset-cpus="${CPU_CORES[$idx]}" "$IMAGE_NAME"
            docker stop "$container" && docker rm "$container"
            docker rename "$NEW_CONTAINER" "$container"
            echo "$container has been updated."
        fi
    done
    echo "All containers are up to date."
}

# Start the first container
start_container() {
    local container_name=$1
    local core=$2
    echo "Starting $container_name on CPU core $core..."
    docker run -d --name "$container_name" --cpuset-cpus="$core" "$IMAGE_NAME"
}

# Initialize state counters
reset_states() {
    busy_count=(0 0)
    idle_count=(0 0 0)
}

# Main logic loop
reset_states
start_container "${CONTAINERS[0]}" "${CPU_CORES[0]}"
last_update=$(date +%s)

while true; do
    now=$(date +%s)

    for i in ${!CONTAINERS[@]}; do
        container="${CONTAINERS[$i]}"
        if docker ps --filter "name=$container" --format "{{.Names}}" | grep -q "$container"; then
            cpu_usage=$(get_cpu_usage "$container")
            echo "CPU usage for $container: $cpu_usage%"

            if (( $(echo "$cpu_usage > $BUSY_LIMIT" | bc -l) )); then
                ((busy_count[i]++))
                idle_count[i]=0

                if [[ $i -lt 2 && ${busy_count[i]} -ge $STATE_COUNT && ! $(docker ps -q -f name=${CONTAINERS[i+1]}) ]]; then
                    echo "Starting ${CONTAINERS[i+1]} on CPU core ${CPU_CORES[i+1]}..."
                    start_container "${CONTAINERS[i+1]}" "${CPU_CORES[i+1]}"
                fi
            else
                busy_count[i]=0
                if [[ $i -gt 0 ]]; then
                    ((idle_count[i]++))
                    if [[ ${idle_count[i]} -ge $STATE_COUNT && $(docker ps -q -f name=${CONTAINERS[i]}) ]]; then
                        echo "Stopping ${CONTAINERS[i]} due to idleness."
                        docker stop "${CONTAINERS[i]}" && docker rm "${CONTAINERS[i]}"
                    fi
                fi
            fi
        fi
    done

    # Perform periodic updates
    if (( now - last_update >= UPDATE_CHECK_INTERVAL )); then
        refresh_containers
        last_update=$(date +%s)
    fi

    sleep "$POLL_INTERVAL"
done
