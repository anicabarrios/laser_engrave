#!/bin/bash

# Make script exit if any command fails
set -e

# Debug - print current directory
echo "Current directory: $(pwd)"

# Install Flutter
git clone https://github.com/flutter/flutter.git --depth 1 --branch stable _flutter
export PATH="$PATH:$(pwd)/_flutter/bin"

# Debug - show Flutter installation
echo "Flutter installed at: $(pwd)/_flutter"

# Check Flutter and set to web
flutter doctor -v
flutter config --enable-web

# Build the project
flutter build web --release

# Debug - verify the build output
echo "Build completed. Content of build directory:"
ls -la build/web