#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Flutter installation..."

# Install Flutter in a compact way
git clone https://github.com/flutter/flutter.git --depth 1 -b stable _flutter
export PATH="$PATH:$PWD/_flutter/bin"

echo "Flutter installed. Running flutter doctor..."
flutter doctor -v

echo "Enabling web..."
flutter config --enable-web

echo "Building project..."
flutter build web --release

echo "Build completed successfully!"
ls -la build/web