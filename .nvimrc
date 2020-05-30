" Required
filetype on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Enable hidden buffers
set hidden

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
"*****************************************************************************
"" Editing
"*****************************************************************************"

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4         " unify
set shiftround            " always indent/outdent to the nearest tabstop

set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

" Line break on 500 characters
set lbr
set tw=500

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

"" Status bar
set laststatus=2

" Disable visualbell
set noerrorbells visualbell t_vb=

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" QOL Shortcuts
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

"*****************************************************************************
"" Mappings
"*****************************************************************************

" Map leader to space
let mapleader=" "

" Center search nexts
nnoremap n nzzzv
nnoremap N Nzzzv

" Enter normal mode with jk or kj
inoremap jk <ESC>
inoremap kj <ESC>

" Save with ctrl+s and leader+s
nnoremap <silent> <C-S> :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>
nnoremap <silent> <Leader>s :if expand("%") == ""<CR>browse confirm w<CR>else<CR>confirm w<CR>endif<CR>

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" move vertically by visual line
nnoremap j gj
nnoremap k gk
