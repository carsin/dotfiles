"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntax highlighting based on file names
filetype plugin on
filetype indent on
syntax on
syntax enable

set hidden " keep more info in memory to speed things up
set history=500 " How many lines of history vim has to remember

set autoread " Set to auto read when a file is changed from the outside

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

set encoding=utf8 " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac " Use Unix as the standard file type
set mouse=a
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs ;)
set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Line break on 500 characters
set lbr
set tw=500

set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set clipboard=unnamed " yank across instances

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" highlight last insert text
nnoremap gV `[v`]
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors
set so=10 " Set 10 lines to the cursor - when moving vertically using j/k
set number " line numbering
set showcmd " show last entered command
set wildmenu " visual auto complete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]
set noeb vb t_vb= " no visual bell or beeping (thank god)
set ruler " Always show current position
set magic " For regular expressions turn magic on
set laststatus=0 " no status bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Binds & Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" " "leader = space

" save file
nmap <leader>w :w!<cr>

" reload vim configuration
map <leader>r :source ~/.vimrc<CR>

 " clear search
nnoremap <leader><space> :noh<CR>

" jk is escape
inoremap jk <ESC>

" Remap VIM 0 to first non-blank character
map 0 ^
