#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export VISUAL=nvim
export EDITOR="$VISUAL"

eval "$(direnv hook zsh)"

alias vim=nvim

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

[ -f "/Users/andre/.ghcup/env" ] && . "/Users/andre/.ghcup/env" # ghcup-env
