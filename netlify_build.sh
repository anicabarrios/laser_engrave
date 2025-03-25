#!/bin/bash

# Make script exit if any command fails
set -e

# Install Flutter
git clone https://github.com/flutter/flutter.git --depth 1 --branch stable _flutter
export PATH="$PATH:$PWD/_flutter/bin"

# Check Flutter and set to web
flutter doctor -v
flutter config --enable-web

# Build the project
flutter build web --release

# Return to the build directory
echo "Build completed successfully!"