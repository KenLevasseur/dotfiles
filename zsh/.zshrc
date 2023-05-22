# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

PATH="$PATH:$HOME/.local/bin"

XDG_CURRENT_DESKTOP=sway

# nvim
alias vim="nvim"

# pip
alias pip3="/usr/bin/python3 -m pip"

# docker
alias prune="yes | docker container prune && yes | docker image prune"
dlogs () {
    docker logs $1 2>&1 | grep $2
}

# go
GOPATH=~/projects/go

# network stuff
alias get-public-ip="curl -w '\n' https://ipinfo.io/ip"

# marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# exa
alias ls="exa -a"

# rg
alias grep="rg"

bonk () {
    ssh-copy-id -i ~/.ssh/id_ed25519.pub $USERNAME@$1
}

fix-keys() {
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys
}

# keybinds
bindkey "^[[3~" delete-char

# local, non-tracked files
[ -f ~/.env.local ] && source ~/.env.local
[ -f ~/.alias.local ] && source ~/.alias.local
[ -f ~/.functions.local ] && source ~/.functions.local

