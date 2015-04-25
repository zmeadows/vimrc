set nocompatible

""""""""""
" VUNDLE "
""""""""""

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'jcf/vim-latex'
Plugin 'scrooloose/syntastic'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'guns/vim-clojure-static.git'
Plugin 'tpope/vim-leiningen.git'
Plugin 'tpope/vim-fireplace.git'
Plugin 'bling/vim-airline'
Plugin 'eagletmt/ghcmod-vim.git'
Plugin 'Shougo/vimproc.vim.git'
Plugin 'parnmatt/vim-root.git'
Plugin 'justinmk/vim-syntax-extra.git'
Plugin 'raichoo/haskell-vim.git'
Plugin 'bronson/vim-trailing-whitespace.git'
Plugin 'Shougo/neocomplete.vim.git'
Plugin 'eagletmt/neco-ghc.git'
Plugin 'osyo-manga/vim-marching.git'
Plugin 'bitc/vim-hdevtools'
Plugin 'zefei/vim-colortuner.git'
Plugin 'hdima/python-syntax.git'
Plugin 'godlygeek/tabular.git'

call vundle#end()

"""""""""""""""""""""
" BASIC VIM OPTIONS "
"""""""""""""""""""""

filetype plugin indent on
syntax on
set showcmd
set hidden
set ruler
set cursorline
set showmode
set number
set backspace=indent,eol,start
set history=1000
set autoread
set ofu=syntaxcomplete#Complete
set gcr=a:blinkon0
set mouse=a
autocmd VimEnter * set cmdheight=1
set title titlestring=%f
set wrap
set noerrorbells

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
set incsearch
set hls
set viminfo='100,f1
set ignorecase
set smartcase

" COLORSCHEME
set t_Co=256
set background=light
color Tomorrow
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1

" MARCHING
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

let g:python_highlight_all = 1

" STATUSLINE
set laststatus=2
set statusline=%F%m%r\ %h%w%=%(%c%V\ %l/%L\ %P%)

" DISABLE FLASHING/BEEPING
autocmd VimEnter * set vb t_vb=

" AUTOMATICALLY REMOVE TRAILING WHITESPACE
autocmd BufWritePre * :%s/\s\+$//e

" GUI OPTIONS
set guifont=PragmataPro\ for\ Powerline:h14

" WILDCARD OPTIONS
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set guioptions=m

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

" DEAL WITH ACCIDENTAL CAPITALIZATION
cnoreabbrev <expr> W   ((getcmdtype() is# ':' && getcmdline() is# 'w')?('W'):('w'))
cnoreabbrev <expr> Wq  ((getcmdtype() is# ':' && getcmdline() is# 'wq')?('Wq'):('wq'))
cnoreabbrev <expr> Wa  ((getcmdtype() is# ':' && getcmdline() is# 'wa')?('Wa'):('wa'))
cnoreabbrev <expr> Wqa ((getcmdtype() is# ':' && getcmdline() is# 'wqa')?('Wqa'):('wqa'))
cnoreabbrev <expr> Q   ((getcmdtype() is# ':' && getcmdline() is# 'q')?('Q'):('q'))
cnoreabbrev <expr> Qa  ((getcmdtype() is# ':' && getcmdline() is# 'qa')?('Qa'):('qa'))

" TAB NAVIGATION
noremap <silent> <A-H> :execute 'sileqt! tabmove ' . (tabpagenr()-2)<CR>
noremap <silent> <A-L> :execute 'silent! tabmove ' . tabpagenr()<CR>

" SWITCH PANES IN INSERT MODE
inoremap <C-w> <C-o><C-w>

"""""""""""""""""""
" PLUGIN SETTINGS "
"""""""""""""""""""

" NEOCOMPLETE
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" TAGBAR
let g:tagbar_autofocus = 1

" SYNTASTIC
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options='-std=c++11'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" VIM-LATEX
"
let g:tex_flavor='latex'
let g:Tex_TreatMacViewerAsUNIX = 1
let g:Tex_ExecuteUNIXViewerInForeground = 1
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_ps = 'open -a Preview'
let g:Tex_ViewRule_pdf = 'open -a Preview'
" let g:Tex_CompileRule_pdf='lualatex'
" let g:Tex_ViewRule_pdf='zathura'
au FileType tex inoremap inQ \in \mathbb{Q}
au FileType tex inoremap inR \in \mathbb{R}
au FileType tex inoremap inC \in \mathbb{C}
au FileType tex inoremap inZ \in \mathbb{Z}
au FileType tex inoremap inN \in \mathbb{N}
au FileType tex inoremap QED \hfill\textit{Q.E.D.}
au FileType tex inoremap SUM \displaystyle\sum\limits_{}^{<++>}<++>
 \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
au FileType tex inoremap d_ \delta_{}<Left>
au FileType tex inoremap e_ \varepsilon_{}<Left>
au FileType tex inoremap bar \bar{}<++><Left><Left><Left><Left><Left>
au FileType tex inoremap p_ \partial_{}<Left>
au FileType tex inoremap GRAD \vec\nabla
au FileType tex inoremap DIV \vec\nabla \cdot
au FileType tex inoremap CURL \vec\nabla \times
au FileType tex inoremap INT \int_{}{<++>}<++>
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>


""""""""""""""""""""""""""""""""""""
" LANGUAGE SPECIFIC SETTINGS/BINDS "
""""""""""""""""""""""""""""""""""""

" MAKE/CHECK COMMANDS
au FileType c,cpp  set makeprg=make
au FileType java   set makeprg=javac\ \-g\ %

" KEY BINDS
au FileType c,cpp noremap ; $i<right>;<esc>

vmap <Enter> :Tab<Space>/

