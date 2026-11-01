# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Suppress Powerlevel10k warning quietly
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Source the Catppuccin theme for zsh-syntax-highlighting
[[ -f ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh ]] && source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Load zsh-syntax-highlighting plugin
[[ -f ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Android SDK
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# Wayland native rendering for Electron applications
export ELECTRON_OZONE_PLATFORM_HINT="auto"

# Chrome executable
export CHROME_EXECUTABLE="/usr/sbin/google-chrome-stable"

# Helper to avoid duplicate PATH entries
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
    unfunction nvm 2>/dev/null || true
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

# PHP Herd-Lite configuration
if [[ ":$PHP_INI_SCAN_DIR:" != *":$HOME/.config/herd-lite/bin:"* ]]; then
    export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin${PHP_INI_SCAN_DIR:+:$PHP_INI_SCAN_DIR}"
fi

# Modern CLI utilities
command -v fzf &>/dev/null && eval "$(fzf --zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
