" install vim-plug if not present
if empty(glob('$HOME/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

" {{{ PLUGINS
call plug#begin('~/.vim/plugged')

" {{{ ESSENTIAL
Plug 'tpope/vim-sensible'
Plug 'ajh17/VimCompletesMe'
Plug 'tpope/vim-commentary'
Plug 'coderifous/textobj-word-column.vim'
Plug 'romainl/vim-qf'

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_executable_haskell = 'gutenhasktags'
let gutentags_project_info = [
  \ {'type': 'haskell', 'glob': '*.cabal'},
  \ {'type': 'haskell', 'glob': '*/*.hs'},
  \ {'type': 'haskell', 'glob': 'stack.yaml'},
  \ {'type': 'haskell', 'glob': '*.hs'}
  \ ]

Plug 'godlygeek/tabular'
vnoremap <Enter> :Tab<Space>/

Plug 'ntpeters/vim-better-whitespace'
autocmd BufWritePre * StripWhitespace

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
nnoremap <leader>f :Files<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}

" {{{ LANGUAGE-SUPPORT
Plug 'parnmatt/vim-root'
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }

Plug 'neovimhaskell/haskell-vim', { 'for' : 'haskell' }
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1

Plug 'vim-pandoc/vim-pandoc', { 'for' : ['markdown', 'pdc'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for' : ['markdown', 'pdc'] }
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
" }}}

" {{{ APPEARANCE
Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'nanotech/jellybeans.vim'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-syntax-extra'

Plug 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': 'jellybeans' }
" }}}

" {{{ USEFUL AND UNINTRUSIVE
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
" }}}

call plug#end()
" }}}

" {{{ BACKUP/UNDO/SWAP FILES
silent !mkdir ~/.vim/backups > /dev/null 2>&1
silent !mkdir ~/.vim/backups/files > /dev/null 2>&1
set backupdir=~/.vim/backups/files
set backup

silent !mkdir ~/.vim/backups/undo_history > /dev/null 2>&1
set undodir=~/.vim/backups/undo_history
set undofile

silent !mkdir ~/.vim/backups/swap_files > /dev/null 2>&1
set directory=~/.vim/backups/swap_files
" }}}

" {{{ VIM SETTINGS
set foldmethod=marker
set number
set numberwidth=3
set nowrap

set background=dark
color base16-ateliersulphurpool

map <SPACE> <leader>

highlight SpecialKey ctermfg=White ctermbg=Red
set list
set listchars=tab:T>

set hls is ic scs

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc
" }}}

" {{{ ALIASES
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

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
" }}}
