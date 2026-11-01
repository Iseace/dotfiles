#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Android SDK
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# Wayland native rendering for Electron applications
export ELECTRON_OZONE_PLATFORM_HINT="auto"

# Chrome executable
export CHROME_EXECUTABLE="/usr/sbin/google-chrome-stable"

# Helper functions to avoid duplicate PATH entries
add_to_path_front() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) export PATH="$1:$PATH" ;;
    esac
}

add_to_path_back() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) export PATH="$PATH:$1" ;;
    esac
}

# User binaries & CLI tools
add_to_path_front "$HOME/.local/bin"
add_to_path_front "$HOME/.config/herd-lite/bin"
add_to_path_front "$ANDROID_SDK_ROOT/platform-tools"
add_to_path_back "$HOME/flutter/bin"
add_to_path_back "$ANDROID_HOME/emulator"
add_to_path_back "$ANDROID_HOME/tools"
add_to_path_back "$ANDROID_HOME/tools/bin"

# Node Version Manager (lazy-loaded for instant terminal startup)
export NVM_DIR="$HOME/.nvm"
add_to_path_front "$NVM_DIR/versions/node/v20.20.0/bin"

nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

# PHP Herd-Lite configuration
if [[ ":$PHP_INI_SCAN_DIR:" != *":$HOME/.config/herd-lite/bin:"* ]]; then
    export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin${PHP_INI_SCAN_DIR:+:$PHP_INI_SCAN_DIR}"
fi

# Modern CLI utilities
command -v fzf &>/dev/null && eval "$(fzf --bash)"
command -v zoxide &>/dev/null && eval "$(zoxide init bash)"
