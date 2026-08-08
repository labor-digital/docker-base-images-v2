#!bin/bash

echo "Preparing development environment..."

# Create additional directories if required
if [ -f "/opt/project/directories.sh" ]; then
  source /opt/project/directories.sh
fi

# Check if we have a build_and_bootstrap-env file to run
if [ -f "/opt/project/build.sh" ]; then
  # Check if we have the env marker already before running the script
  if [ -f "/opt/project/build.ran" ]; then
    echo "Environment is already prepared (marker exists at: /opt/project/build.ran)"
  else
    source /opt/project/build.sh
    [[ $? -ne 0 ]] && exit 1
    touch /opt/project/build.ran
  fi
fi

# Run the bootstrap dev file if we have one
if [ -f "/opt/project/development.sh" ]; then
  source /opt/project/development.sh
fi

# Set the correct permissions for the files
set_permissions

# Override the start command if we have a development script
if [[ $(npm run | grep "^  start:development" | wc -l) > 0 ]]; then
  export APP_RUN_SCRIPT=${APP_RUN_SCRIPT:-"start:development"}
fi