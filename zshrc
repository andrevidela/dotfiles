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

export VISUAL=vim
export EDITOR="$VISUAL"

eval "$(direnv hook zsh)"

[ -f "/home/andre/.ghcup/env" ] && source "/home/andre/.ghcup/env" # ghcup-env
alias vim=nvim

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
