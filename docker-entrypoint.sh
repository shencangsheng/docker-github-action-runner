#!/bin/bash

# Exit on error
set -e

# Check required environment variables
if [ -z "${REPO_URL}" ] || [ -z "${RUNNER_TOKEN}" ] || [ -z "${RUNNER_NAME}" ]; then
    echo "Error: REPO_URL, RUNNER_TOKEN and RUNNER_NAME environment variables are required"
    exit 1
fi

# Configure the runner
echo "Configuring GitHub Actions Runner..."
./config.sh \
    --url "${REPO_URL}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --work "_work" \
    --unattended \
    --replace

# Start the runner and wait for it to finish
echo "Starting GitHub Actions Runner..."
./run.sh &
runner_pid=$!

# Handle shutdown signals
trap 'kill $runner_pid' SIGTERM SIGINT

# Wait for runner process to finish
wait $runner_pid
