#!/bin/bash

# Endless loop for sending HTTP requests
while :; do
    # Calculate a random delay between 5 and 10 seconds
    delay=$((RANDOM % 6 + 5))

    # Log the delay duration
    echo "Pausing for $delay seconds before sending the next request..."

    # Wait for the calculated delay
    sleep $delay

    # Send an asynchronous HTTP GET request
    curl --silent --show-error --request GET "127.0.0.1/compute" &

    # Log the request status
    echo "Asynchronous HTTP GET request initiated."
done
