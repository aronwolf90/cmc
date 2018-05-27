set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab

set wrap
set linebreak
set showbreak=>\ \ \

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-wombat-scheme'

call vundle#end()

filetype plugin indent on

set backspace=2

set mouse=a
let NERDTreeShowHidden=1

:syntax enable

au VimEnter *  NERDTree

