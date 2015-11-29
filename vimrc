set nocompatible
let mapleader="\<Space>"

" PLUGINS {{{
call plug#begin('~/.vim/plugged')

" SHOUGO IS A GENIUS
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite-outline'

nnoremap <Leader>uf :<C-u>Unite -no-split -start-insert file_rec/async<CR>
nnoremap <Leader>uo :<C-u>Unite -no-split outline<CR>

let g:unite_source_grep_max_candidates = 1000
let g:unite_source_grep_search_word_highlight = 'IncSearch'

if executable('ag')
    " Use ag (the silver searcher)
    " https://github.com/ggreer/the_silver_searcher
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
endif

Plug 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1

Plug 'osyo-manga/vim-marching'
let g:marching_clang_command = "clang"

" cooperate with neocomplete.vim
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp =
			\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

Plug 'sirtaj/vim-openscad'
Plug 'sophacles/vim-processing'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'neovimhaskell/haskell-vim'

Plug 'LaTeX-Box-Team/LaTeX-Box'
let g:LatexBox_latexmk_async = 1
let g:LatexBox_show_warnings = 0

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
endif

Plug 'airblade/vim-gitgutter'

Plug 'godlygeek/tabular'
vnoremap <Enter> :Tab<Space>/

Plug 'flazz/vim-colorschemes'
Plug 'kristijanhusak/vim-hybrid-material'

Plug 'freitass/todo.txt-vim'

Plug 'bling/vim-airline'
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''

Plug 'justinmk/vim-syntax-extra'

"Plug 'edkolev/tmuxline.vim'
"let g:tmuxline_preset = 'powerline'
"let g:tmuxline_powerline_separators = 0

Plug 'ntpeters/vim-better-whitespace'
autocmd BufWritePre * StripWhitespace

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

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = "-std=c++11 -stdlib=libc++ -Wall -Werror -pedantic -Wc++11-extensions"

let g:syntastic_c_compiler_options = "-std=gnu99 -Wall -Werror -pedantic"

let g:syntastic_python_checkers = ['pyflakes']

" disable syntastic for some languages
let g:syntastic_latex_checkers = []
let g:syntastic_tex_checkers = []
let g:syntastic_cpp_checkers = []
let g:syntastic_c_checkers = []

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
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

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
color hybrid_material
set antialias
set guioptions=me

if has('gui_running')
    if has('mac')
        set guifont=Sauce\ Code\ Powerline\ Semibold:h12
    endif
endif

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

nnoremap <Leader>ev :e ~/.vimrc<CR>



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


" }}}
