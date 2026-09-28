#!/usr/bin/env bash
# Build script for Cloudflare Pages (the build image has no Flutter preinstalled).
# Pages settings:  Build command: bash cloudflare-build.sh   ·   Output directory: build/web
set -euo pipefail

FLUTTER_VERSION="3.35.3"
FLUTTER_DIR="$HOME/flutter"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  git clone --depth 1 --branch "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi
export PATH="$FLUTTER_DIR/bin:$PATH"

flutter config --no-analytics >/dev/null
flutter --version
flutter pub get
flutter build web --release
