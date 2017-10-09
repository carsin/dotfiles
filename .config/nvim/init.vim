"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible " dont be vi

" syntax highlighting based on file names
filetype on
filetype plugin on
filetype indent on
syntax on

set hidden " keep more info in memory to speed things up
set history=500 " How many lines of history vim has to remembor

set autoread " Set to auto read when a file is changed from the outside

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs ;)

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Linebreak on 500 characters
set lbr
set tw=500

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save

set incsearch " search as characters are entered
set hlsearch " highlight matches
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" highlight last insertext text
nnoremap gV `[v`]

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set so=7 " Set 7 lines to the cursor - when moving vertically using j/k
set number " line numbering
set showcmd " show last entered command
set wildmenu " visual autocomplete for command menu
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

" reload vim config
map <leader>r :source ~/.config/nvim/init.vim<CR>

 " clear search
nnoremap <leader><space> :nohlsearch<CR>

" jk is escape
inoremap jk <ESC>

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
