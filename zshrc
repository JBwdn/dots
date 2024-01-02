export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="lambda"
plugins=(git vi-mode)

bindkey -v
source $ZSH/oh-my-zsh.sh

# Change screen dir:
export SCREENDIR=$HOME/.screen

# Add scripts dir to path:
export PATH="$HOME/Scripts:$PATH"

# binds:
EDITOR=nvim
bindkey '\C-e' edit-command-line

# Aliases:
alias x=exit
alias ":q"=exit
alias p=python3
alias i=ipython
alias j=julia
alias c=clear
alias vi=nvim
alias h="cd $HOME; ls"
alias t="exa -T -L 2"
alias t3="exa -T -L 3"
alias rm="trash"
alias clip="xclip -sel c < "
alias ssh_fwd="eval $(ssh-agent -s) ; ssh-add ~/.ssh/id_ed25519"
alias dots="vi $HOME/dots/"
alias pyloc="git ls-files | grep '.py' | xargs wc -l"

alias mm="micromamba"
alias mamba="micromamba"
alias conda="micromamba"

alias L="screen -ls"
alias S="screen -R"

alias cod="micromamba deactivate"
alias cos="micromamba deactivate; coa"

alias ga="git add"
alias gc="git commit"
alias gcom="git commit -m"

alias pc="pre-commit run --all-files"
alias ct="ctags -R ."

# Functions:
function peco-hist(){
local tac
if which tac > /dev/null; then
	tac="tac"
else
	tac="tail -r"
fi
BUFFER=$(history -5000 | eval $tac | cut -c 8- | fzf --query "$LBUFFER")
CURSOR=$#BUFFER
}
zle -N peco-hist
bindkey '^R' peco-hist

function coa(){
micromamba deactivate
if [ -z "$1" ]; then
	env=$(micromamba env list | tail -n +3 | awk '{print $1;}' | fzf --prompt 'Mamba Activate:')
else
	env=$1
fi
micromamba activate $env
}

function csv(){
    csvtool readable $1 | view -
}
source $HOME/.local_zshrc
