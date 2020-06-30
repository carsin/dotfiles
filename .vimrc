" ▄▄▄▄· ▄• ▄▌▪  ▄▄▌ ▄▄▄▄▄▄ ▄▄▄·  ▄· ▄▌ ▄▄·  ▄▄▄· ▄▄▄  .▄▄ ·        ▐ ▄   ▄▄·       • ▌ ▄ ·.
" ▐█ ▀█▪█▪██▌██ ██•  •██  ▐█ ▀█▪▐█▪██▌▐█ ▌▪▐█ ▀█ ▀▄ █·▐█ ▀. ▪     •█▌▐█ ▐█ ▌▪▪     ·██ ▐███▪
" ▐█▀▀█▄█▌▐█▌▐█·██▪   ▐█.▪▐█▀▀█▄▐█▌▐█▪██ ▄▄▄█▀▀█ ▐▀▀▄ ▄▀▀▀█▄ ▄█▀▄ ▐█▐▐▌ ██ ▄▄ ▄█▀▄ ▐█ ▌▐▌▐█·
" ██▄▪▐█▐█▄█▌▐█▌▐█▌▐▌ ▐█▌·██▄▪▐█ ▐█▀·.▐███▌▐█ ▪▐▌▐█•█▌▐█▄▪▐█▐█▌.▐▌██▐█▌ ▐███▌▐█▌.▐▌██ ██▌▐█▌
" ·▀▀▀▀  ▀▀▀ ▀▀▀.▀▀▀  ▀▀▀ ·▀▀▀▀   ▀ • ·▀▀▀  ▀  ▀ .▀  ▀ ▀▀▀▀  ▀█▄▀▪▀▀ █▪▀·▀▀▀  ▀█▄▀▪▀▀  █▪▀▀▀
" A vimrc carefully created for optimal productivity and speed
" that utilizes vim's best features.
" https://github.com/carsin/dotfiles

" General {{{
set nocompatible

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

set updatetime=300 " Fast updatetime for snappier experience

" Set proper mouse mode
set mouse=a
set ttymouse=xterm2

" }}}
" Plugins {{{

call plug#begin('~/.vim/plugged') " Specify a directory for plugins

Plug 'tpope/vim-surround' " Easy matching pairs
Plug 'scrooloose/nerdtree' " File tree navigator
Plug 'mattn/emmet-vim' " Emmet integration
Plug 'preservim/nerdcommenter' " Easy commenting
Plug 'jiangmiao/auto-pairs' " Auto pairs
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete
Plug 'mhinz/vim-startify' " Fancy start page
Plug 'chaoren/vim-wordmotion' " Improve vim word motion (ex: snake_case and camelCase)
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, etc finder.
Plug 'sheerun/vim-polyglot' " Syntax for various languages
Plug 'psliwka/vim-smoothie' " Nice scrolling animation
Plug 'airblade/vim-rooter' " Changes Vim working directory to project root
Plug 'junegunn/goyo.vim' " Distraction-free writing mode
Plug 'vimwiki/vimwiki' " Personal wiki

" COLORS:
Plug 'sainnhe/gruvbox-material' " Colorscheme
Plug 'morhetz/gruvbox' " Gruvbox

call plug#end() " Initialize plugin system

" }}}
" Plugin Settings {{{
" CoC {{{
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Makes <cr> select the first completion item, confirm when no item selected, and formats the code:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Disable CoC for certain filetypes
autocmd BufNew,BufEnter *.md,*.txt execute "silent! CocDisable"
autocmd BufLeave *.md,*.txt execute "silent! CocEnable"
" }}}
" Goyo {{{
" Close Goyo with :wq
function! s:goyo_enter()
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> wq! let b:quitting_bang = 1 <bar> q!
endfunction
function! s:goyo_leave()
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

let g:goyo_height = '100%'
let g:goyo_width= '40%'
" }}}

"let g:lightline = {'colorscheme' : 'gruvbox_material'}
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if nerdtree is the only window left
map <C-n> :NERDTreeToggle<CR>

autocmd vimenter * colorscheme gruvbox

" Use a template when generating new vimwiki diary files
au BufNewFile ~/vimwiki/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'

" Use markdown for vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" }}}
" Editing {{{

set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs
set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Line break on a lot of characters
set lbr
set tw=5000000

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

set mousefocus " Focus follows mouse

" }}}
" UI {{{

" Enable true color
if exists('+termguicolors')
    " Fix color bugs in tmux
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set background=dark
set t_Co=256
autocmd vimenter * colorscheme gruvbox

let &t_EI .= "\<Esc>[0 q"
let &t_SI .= "\<Esc>[6 q"

set so=10 " Set 10 lines to the cursor - when moving vertically using j/k
set number " line numbering
set showcmd " show last entered command
set wildmenu " visual auto complete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]
set noeb vb t_vb= " no visual bell or beeping (thank god)
set ruler " Always show current position
set magic " For regular expressions turn magic on
set noshowmode " Remove redundant status bar elements
set foldenable " Fold code
set foldmethod=marker " Fold code with {{{}}}
set linespace=0 " No extra space between lines
set laststatus=2 " Show statusline
" More natural split opening
set splitbelow
set splitright

" Change vertical split character to solid line instead of line with gaps
set fillchars+=vert:│

" Custom statusline {{{
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#CursorIM#%{(mode()=='v')?'\ \ VISUAL\ ':''}
"set statusline+=\ %n\           " buffer number
"set statusline+=%#Visual#       " colour
set statusline+=%{&paste?'\ \ PASTE\ ':''}
set statusline+=%{&spell?'\ \ SPELL\ ':''}
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     " colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                          " right align
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=\ %3p%%\                " percentage
"}}}
" }}}
" Binds & Mappings {{{

let mapleader=" " "leader = space

" save file
nmap <leader>s :w!<cr>

" reload vim configuration
map <leader>r :source ~/.vimrc<CR>

 " clear search
nnoremap <leader><space> :let @/ = ""<CR>

" jk is escape
inoremap jk <ESC>

" Remap VIM 0 to first non-blank character
map 0 ^

" unbind annoying help page
nmap <F1> <nop>

set pastetoggle=<F2> " Toggle pastemode with f2

" Toggle goyo
nnoremap <leader>go :Goyo<cr>

" Toggle Spellcheck
noremap <F3> :setlocal spell! spelllang=en_us<CR>

" Insert date / time
nnoremap <leader>id "=strftime("%a, %b %d %Y")<CR>p
nnoremap <leader>it "=strftime("%I:%M %p")<CR>p

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" close buffer
nmap <leader>Q :bd!<cr>

" Open new empty buffer
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Split binds
nmap <leader>- :split<CR>
nmap <leader>\| :vsplit<CR>

" }}}
