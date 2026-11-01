#
# ~/.profile - Session environment
#

# Android SDK
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# Wayland native rendering for Electron applications
export ELECTRON_OZONE_PLATFORM_HINT="auto"

# Add directories to PATH if not already included
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

case ":$PATH:" in
  *":$ANDROID_HOME/emulator:"*) ;;
  *) export PATH="$PATH:$ANDROID_HOME/emulator" ;;
esac

case ":$PATH:" in
  *":$ANDROID_HOME/tools:"*) ;;
  *) export PATH="$PATH:$ANDROID_HOME/tools" ;;
esac

case ":$PATH:" in
  *":$ANDROID_HOME/tools/bin:"*) ;;
  *) export PATH="$PATH:$ANDROID_HOME/tools/bin" ;;
esac

case ":$PATH:" in
  *":$ANDROID_HOME/platform-tools:"*) ;;
  *) export PATH="$PATH:$ANDROID_HOME/platform-tools" ;;
esac

case ":$PATH:" in
  *":$ANDROID_SDK_ROOT/platform-tools:"*) ;;
  *) export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH" ;;
esac
