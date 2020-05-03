alias e='emacsclient -c'
alias vi=e
alias g=git
alias icat="kitty +kitten icat"
set fish_greeting
export EDITOR=/usr/bin/vim
export JAVA_HOME=(/usr/libexec/java_home -v 11)
direnv hook fish | source
export env GOPATH=$HOME/.go
export env GOROOT=/usr/local/opt/go/libexec
set -x PATH $PATH /usr/local/bin/go $GOPATH/bin
status --is-interactive; and source (rbenv init -|psub)
