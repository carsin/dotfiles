" init
set nocompatible " dont be vi

filetype on " syntax highlighting based on file names
syntax on " syntax highlighting based on file names


" editing

set hidden " keep more info in memory to speed things up
set history=100 " keep more info in memory to speed things up

filetype indent on " load filetype-specific indent files
set tabstop=4 " number of visual spaces per tab
set shiftwidth=4 " number of spaces in tab when editing
set expandtab " tabs are spaces
set smartindent
set autoindent

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save

set incsearch " search as characters are entered
set hlsearch " highlight matches

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last insertext text
nnoremap gV `[v`]

" ui
set number " line numbering
set showcmd " show last entered command
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]

" mappings
let mapleader=" " "leader = space

" reload vim config
map <leader>r :source ~/.vimrc<CR>

 " clear search
nnoremap <leader><space> :nohlsearch<CR>

" jk is escape
inoremap jk <ESC>
