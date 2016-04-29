set nocompatible

let hostname = substitute(system('hostname'), '\n', '', '')

if (hostname != "macbook" && hostname != "titan")
    echoerr "Unrecognized hostname encountered: " . hostname
endif

" install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

" PLUGINS
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'

Plug 'rhysd/clever-f.vim'

Plug 'altercation/vim-colors-solarized'

Plug 'sirtaj/vim-openscad', { 'for' : 'scad' }
Plug 'sophacles/vim-processing', { 'for' : 'pde' }

Plug 'vim-pandoc/vim-pandoc', { 'for' : ['markdown', 'pdc'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for' : ['markdown', 'pdc'] }
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0

Plug 'coderifous/textobj-word-column.vim'

Plug 'neovimhaskell/haskell-vim', { 'for' : 'haskell' }
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1

autocmd Filetype tex map <Leader>vl :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line('.')<CR> %<.pdf %<CR><CR>
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for' : 'tex' }
let g:LatexBox_latexmk_async = 1
let g:LatexBox_show_warnings = 0

Plug 'godlygeek/tabular'
vnoremap <Enter> :Tab<Space>/

Plug 'parnmatt/vim-root'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#syntastic#enabled = 1

let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'c' : 'C',
      \ 'v' : 'V',
      \ 'V' : 'V',
      \ 's' : 'S',
      \ 'S' : 'S',
      \ }

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create(['%t'])
    let g:airline_section_c = airline#section#create([])
    let g:airline_section_x = airline#section#create([])
    let g:airline_section_y = airline#section#create([])
    let g:airline_section_z = airline#section#create(['%l',':','%c'])
    let g:airline_section_warning = airline#section#create(['syntastic'])
    AirlineRefresh
endfunction

autocmd VimEnter,BufEnter * call AirlineInit()

Plug 'justinmk/vim-syntax-extra'

Plug 'ntpeters/vim-better-whitespace'
autocmd BufWritePre * StripWhitespace

Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

Plug 'xolox/vim-misc'

Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
let g:lua_check_syntax = 0 " turn off syntastic feature duplication

Plug 'scrooloose/syntastic'
call plug#end()

syntax enable
filetype plugin indent on
let mapleader="\<Space>"
set path+=**
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
let &titlestring = "vim"
set noerrorbells
set lazyredraw
set encoding=utf8
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
endif

" ROOT
au BufNewFile,BufRead *.C set filetype=cpp.root

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
color solarized
hi Normal ctermbg=none
set antialias
set guioptions=me

if has('gui_running')
    set guifont=InputMonoNarrow\ Medium:h13
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

" LOCAL VIMRC
let b:thisdir=expand("%:p:h")
let b:lvim=b:thisdir."/.localvimrc"
if (filereadable(b:lvim))
    execute "source ".b:lvim
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let root_flags = system('root-config --cflags')[:-2]
if hostname == "titan"
    let rc_lflags = system('rc get_ldflags')[:-2]
    let rc_cxx_flags = system('rc get_cxxflags')[:-2]
    let g:syntastic_cpp_compiler = 'g++'
    let g:syntastic_cpp_compiler_options = "-std=c++11 " . root_flags . ' ' . rc_lflags . ' ' . rc_cxx_flags
    "let g:syntastic_cpp_compiler_options = "-std=c++11 -stdlib=libc++ -Wall -Wc++11-extensions -Wc99-extensions " . root_flags . ' ' . rc_flags

    let g:syntastic_c_compiler = 'gcc'
    "let g:syntastic_c_compiler_options = "-std=gnu99 -Wall -Werror -pedantic"
elseif hostname == "macbook"
    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = "-std=c++14 -stdlib=libc++ -Wall -Wc++11-extensions -Wc99-extensions " . root_flags

    let g:syntastic_c_compiler = 'clang'
    let g:syntastic_c_compiler_options = "-std=gnu99 -Wall -Werror -pedantic"
endif

let g:syntastic_python_checkers = ['pyflakes']

" disable syntastic for some languages
let g:syntastic_latex_checkers = []
let g:syntastic_tex_checkers = []

nnoremap <Leader>ev :e ~/.vimrc<CR>
nnoremap <Leader>ez :e ~/.zshrc<CR>

function! WhichTabNo(bufNo)
    let tabNos = []
    for tabNo in range(1, tabpagenr("$"))
        for bufInTab in tabpagebuflist(tabNo)
            if (bufInTab == a:bufNo)
                call add(tabNos, tabNo)
            endif
        endfor
    endfor
    let numBufsFound = len(tabNos)
    return (numBufsFound == 0) ? [-1] : tabNos
endfunction

function! SplitHeader()
    let next_file = ""
    if (expand ("%:e") == "cpp")
        let next_file = expand('%:t:r').".h"
    else
        let next_file = expand('%:t:r').".cpp"
    endif

    let next_file=findfile(next_file)
    if !empty(glob(next_file))
        let visible = {}
        for b in tabpagebuflist()
            let visible[b] = 1
        endfor

        let bn = bufname("^".next_file."$")
        if (bn == "" || !has_key(visible, bufnr(bn)))
            execute "vertical sfind ".next_file
        else
            echo "file already open"
        endif
    endif
endfunction

nnoremap <Leader>hs :call SplitHeader()<CR>

" COMMAND ALIASES
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" correct common/annoying typos
call SetupCommandAlias('W', 'w')
call SetupCommandAlias('Wa', 'wa')
call SetupCommandAlias('WA', 'wa')
call SetupCommandAlias('Wqa', 'wqa')
call SetupCommandAlias('WQa', 'wqa')
call SetupCommandAlias('WQA', 'wqa')
call SetupCommandAlias('Vsplit', 'vsplit')
call SetupCommandAlias('VSplit', 'vsplit')
call SetupCommandAlias('Split', 'split')
call SetupCommandAlias('SPlit', 'split')

fun! StartMarkdownPreview()
    call vimproc#system_bg('open -a Marked\ 2 ' . expand('%:p'))
    autocmd InsertLeave *.md update
endfun

autocmd Filetype markdown nnoremap <Leader>pp :call StartMarkdownPreview()<CR>


" UNITE

let g:unite_source_grep_max_candidates = 5000
let g:unite_source_grep_search_word_highlight = 'IncSearch'

if executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '--vimgrep' .
                \' --ignore "RootCoreBin"'
    let g:unite_source_grep_recursive_opt = ''
endif

" filetypes to ignore
set wildignore=*.o,*.pyc
call unite#custom#source('file, file_rec, file_rec/async, grep',
    \ 'ignore_globs', split(&wildignore, ','))

" directories to ignore with unite
call unite#custom_source('file, file_rec, file_rec/async, grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.svn/',
      \ '\.bzr/',
      \ 'build/',
      \ 'images/',
      \ ], '\|'))

" unite window keybinds
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <buffer> <TAB>   <Plug>(unite_select_next_line)
    imap <buffer> <S-TAB> <Plug>(unite_select_previous_line)
endfunction

fun! MyUniteOpenFileRec()
    Unite -no-split -start-insert -auto-preview file_rec
endfun

fun! MyUniteNewFile()
    Unite file file/new -no-split -buffer-name=notes -start-insert -auto-preview
endfun

fun! MyUniteOutline()
    Unite -no-split -start-insert outline
endfun

fun! MyUniteGrep()
    Unite -no-split grep:.
endfun

nnoremap <Leader>uf :<C-u>call MyUniteOpenFileRec()<CR>
nnoremap <Leader>un :<C-u>call MyUniteNewFile()<CR>
nnoremap <Leader>uo :<C-u>call MyUniteOutline()<CR>
nnoremap <Leader>ug :<C-u>call MyUniteGrep()<CR>
