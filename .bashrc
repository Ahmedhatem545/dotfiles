if [[ $- == *i* ]]; then export SHELL=/usr/bin/zsh; exec /usr/bin/zsh -l; fi
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Initialize Starship prompt
eval "$(starship init bash)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export PATH=$HOME/.local/bin:$PATH:~/.npm-global/bin
export PATH="/opt/flutter/bin:$PATH"

# Android SDK
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH"

# Set JAVA_HOME to user-installed JDK if present
if [ -z "$JAVA_HOME" ] && [ -d "$HOME/.local/java" ]; then
	export JAVA_HOME=$(find "$HOME/.local/java" -maxdepth 1 -type d -name 'jdk*' -print -quit)
	if [ -n "$JAVA_HOME" ]; then
		export PATH="$JAVA_HOME/bin:$PATH"
	fi
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
export PATH="$PATH":"$HOME/.pub-cache/bin"
