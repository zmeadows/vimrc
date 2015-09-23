set nocompatible

" PLUGINS {{{
call plug#begin('~/.vim/plugged')
nnoremap <Leader>Pu :PlugUpdate4<CR>
nnoremap <Leader>Pc :PlugClean<CR>
nnoremap <Leader>Pi :PlugInstall4<CR>

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }

Plug 'sirtaj/vim-openscad'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'LaTeX-Box-Team/LaTeX-Box'

Plug 'kien/ctrlp.vim'
" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

Plug 'hdima/python-syntax'
let python_highlight_all = 1

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif

Plug 'FelikZ/ctrlp-py-matcher'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

Plug 'airblade/vim-gitgutter'

Plug 'godlygeek/tabular'
vnoremap <Enter> :Tab<Space>/

Plug 'flazz/vim-colorschemes'
Plug 'kristijanhusak/vim-hybrid-material'

Plug 'wellle/tmux-complete.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'freitass/todo.txt-vim'

Plug 'bling/vim-airline'
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1
"let g:airline_left_sep=''
"let g:airline_right_sep=''


Plug 'justinmk/vim-syntax-extra'

"Plug 'edkolev/tmuxline.vim'
"let g:tmuxline_preset = 'powerline'
"let g:tmuxline_powerline_separators = 0

Plug 'tmux-plugins/vim-tmux'

Plug 'christoomey/vim-tmux-runner'
let g:VtrClearBeforeSend = 0

Plug 'ntpeters/vim-better-whitespace'
autocmd VimEnter * silent! ToggleStripWhitespaceOnSave

Plug 'JuliaLang/julia-vim'
let g:latex_to_unicode_auto = 1

Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-leiningen'
Plug 'tpope/vim-fireplace'

Plug 'tpope/vim-fugitive'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
let g:easytags_async=1
Plug 'xolox/vim-lua-ftplugin'
let g:lua_check_syntax = 0

Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_compiler_options = "-std=gnu99 -Wall -Werror -pedantic"
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_latex_checkers = []

Plug 'rking/ag.vim'

Plug 'majutsushi/tagbar'

Plug 'terryma/vim-expand-region'

Plug 'xolox/vim-colorscheme-switcher'
let g:colorscheme_switcher_exclude_builtins=1

call plug#end()
" }}}

" BASIC VIM SETTINGS {{{
syntax enable
filetype plugin indent on
set showcmd
set hidden
set ruler
set cursorline
set showmode
set number
set rnu
set backspace=indent,eol,start
set history=1000
set autoread
set gcr=a:blinkon0
set mouse=a
autocmd VimEnter * set cmdheight=1
set title titlestring=%f
set noerrorbells
set lazyredraw
set encoding=utf8

" INDENT/TAB/SPACES
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set foldmethod=marker
set linebreak
set nowrap

" SEARCH
set hls is ic scs
set viminfo='100,f1

" APPEARANCE
set t_Co=256
set background=dark
color hybrid
set guifont=PragmataPro\ for\ Powerline:h14
set antialias
set guioptions=m

" STATUSLINE
set laststatus=2

" DISABLE FLASHING/BEEPING
autocmd VimEnter * set vb t_vb=

" BACKUPS
silent !mkdir ~/.vim/backups > /dev/null 2>&1
silent !mkdir ~/.vim/backups/files > /dev/null 2>&1
set backupdir=~/.vim/backups/files
set backup

" UNDO
silent !mkdir ~/.vim/backups/undo_history > /dev/null 2>&1
set undodir=~/.vim/backups/undo_history
set undofile

" SWAP
silent !mkdir ~/.vim/backups/swap_files > /dev/null 2>&1
set directory=~/.vim/backups/swap_files
" }}}

" CUSTOM KEYBINDS {{{
let mapleader="\<Space>"

nnoremap <Leader>ev :e ~/.vimrc<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>Q :q<CR>

nnoremap <Leader>cf :%y+<CR>


" }}}

" REPL INTERACTION {{{

function! OpenREPL()
    if &filetype == "julia"
        VtrOpenRunner { 'cmd': 'julia\ -p\ 4' }
    else
        echo "OpenREPL: filetype not recognized!"
    endif
endfunction

function! LoadFileREPL()
    if &filetype == "julia"
        call VtrSendCommand("include(\"" . expand("%:p") . "\")")
    else
        echo "repl not supported!"
    endif
endfunction


nnoremap <Leader>ro :call OpenREPL()<CR>
nnoremap <Leader>rl :call LoadFileREPL()<CR>
vnoremap <Leader>rs :VtrSendLinesToRunner<CR>
"nnoremap <Leader>rl :VtrKillRunner<CR>

"autocmd Filetype julia nnoremap <Leader>rl
" \ :call LoadFileREPL("julia")<CR>

" }}}
