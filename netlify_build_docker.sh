#!/bin/bash

# Make script exit if any command fails
set -e

# Use Docker to build the Flutter project
docker run --rm -v $(pwd):/app -w /app cirrusci/flutter:stable flutter build web --release

# Return to the build directory
echo "Build completed successfully!"