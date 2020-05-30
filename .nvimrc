" ───
" ─── SETUP ──────────────────────────────────────────────────────────────────────
" ───
filetype on

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Enable hidden buffers
set hidden

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

set history=500 " How many lines of history vim has to remember

set autoread " Set to auto read when a file is changed from the outside

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" ───
" ─── EDITOR ──────────────────────────────────────────────────────────────────────
" ───
set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs


set shiftwidth=4 " 4 spaces = tab
set tabstop=4 " 4 spaces = tab
set softtabstop=4 " unify
set shiftround " always indent/outdent to the nearest tabstop
set ai " Auto indent
set si " Smart indent

set wrap " Wrap lines
set lbr " wrap on whitespace--not character
set wm=1 " Line break 1 char away from right side of screen

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save

" Searching
set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

" ───
" ─── PLUGINS ──────────────────────────────────────────────────────────────────────
" ───
call plug#begin('~/.vim/plugged')

" ───
" ─── VISUAL ──────────────────────────────────────────────────────────────────────
" ───
syntax on

set so=15 " Scroll with j/k up or down within 15 lines of top or bottom of vim
set number " line numbering
set wildmenu " visual auto complete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]
set noeb vb t_vb= " no visual bell or beeping (thank god)
set ruler " Always show current position
set magic " For regular expressions turn magic on
set laststatus=2 " statusbar

" ───
" ─── MAPPINGS/BINDS ──────────────────────────────────────────────────────────────────────
" ───
let mapleader=" " " Map leader to space

" Center search nexts
nnoremap n nzzzv
nnoremap N Nzzzv

" Enter normal mode with jk or kj
inoremap jk <ESC>
inoremap kj <ESC>

" Save with ctrl+s and leader+s
nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
nnoremap <silent> <Leader>s :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

" Remove search highlighting
nnoremap <silent> <leader><space> :noh<cr>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Remap VIM 0 to first non-blank character
map 0 ^

" ───
" ─── ABBREVIATIONS ──────────────────────────────────────────────────────────────────────
" ───
" Shortcuts to fix accidental capitalizations in commands
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
