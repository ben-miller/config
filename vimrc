syntax on
"set scrolloff=5

set modeline
set ls=2

set mouse=a

"set autoindent
set ruler

colorscheme ron
syntax enable
syntax on

set expandtab
set tabstop=4

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

inoremap  <buffer> <silent> <Up> <C-o>gk
inoremap  <buffer> <silent> <Down> <C-o>gj

execute pathogen#infect()

"Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Plugin 'gmarik/Vundle.vim'
call vundle#end()
