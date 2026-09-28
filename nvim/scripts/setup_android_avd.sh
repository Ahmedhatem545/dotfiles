#!/usr/bin/env bash
set -euo pipefail

ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}"
CMDLINE_ZIP_URL=${CMDLINE_ZIP_URL:-"https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip"}
AVD_NAME=${AVD_NAME:-"pixel_33"}
API_LEVEL=${API_LEVEL:-"33"}
SYS_IMAGE=${SYS_IMAGE:-"system-images;android-${API_LEVEL};google_apis;x86_64"}

echo "Using ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
mkdir -p "$ANDROID_SDK_ROOT"
mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"

echo "Downloading Android command-line tools..."
TMPZIP=$(mktemp -p /tmp cmdline-tools-XXXXXX.zip)
if ! curl -fSL "$CMDLINE_ZIP_URL" -o "$TMPZIP"; then
  echo "Failed to download command-line tools from $CMDLINE_ZIP_URL"
  exit 1
fi

echo "Unpacking..."
unzip -q "$TMPZIP" -d "$ANDROID_SDK_ROOT/cmdline-tools"
rm "$TMPZIP"

# Some zips contain a top-level folder named 'cmdline-tools'; move to 'latest'
if [ -d "$ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools" ]; then
  rm -rf "$ANDROID_SDK_ROOT/cmdline-tools/latest" || true
  mv "$ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools" "$ANDROID_SDK_ROOT/cmdline-tools/latest"
fi

export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH"

echo "PATH set for this session: $PATH"

echo "Installing platform-tools, emulator, platforms and system-image (this may take time)..."
# Use sdkmanager to install packages
yes | sdkmanager --sdk_root="$ANDROID_SDK_ROOT" --install "platform-tools" "emulator" "platforms;android-${API_LEVEL}" "$SYS_IMAGE"

echo "Accepting licenses..."
yes | sdkmanager --sdk_root="$ANDROID_SDK_ROOT" --licenses

# Create AVD
echo "Creating AVD named $AVD_NAME..."
# Ensure avdmanager is available on PATH
avdmanager --sdk_root="$ANDROID_SDK_ROOT" create avd -n "$AVD_NAME" -k "$SYS_IMAGE" -d pixel --force || true

echo "AVD created: $AVD_NAME"

echo "Starting emulator in background..."
"$ANDROID_SDK_ROOT/emulator/emulator" -avd "$AVD_NAME" -netdelay none -netspeed full &

echo "Emulator started. You can check with 'adb devices' or 'flutter devices'."

echo "Done. If you want to persist environment variables, add to your shell profile:"
echo "  export ANDROID_SDK_ROOT=\"$ANDROID_SDK_ROOT\""
echo "  export PATH=\"$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:\$PATH\""
