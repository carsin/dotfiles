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

filetype plugin indent on " Load plugins according to detected filetype.
syntax on                 " Enable syntax highlighting.

set hidden                " hide buffers even if they're edited
set history=500           " How many lines of history vim has to remember

set encoding=utf8         " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac      " Use Unix as the standard file type

set updatetime=500        " Fast updatetime for snappier experience

" Set proper mouse mode
set mouse=a

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

" }}}
" Plugins {{{
call plug#begin('~/.config/nvim/plugins/installed') " Specify a directory for plugins

Plug 'tpope/vim-commentary'                             " Simply toggle comments with gc
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Autocomplete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Fuzzy file finder
Plug 'junegunn/fzf.vim'                                 " fzf based commands and mappings
Plug 'justinmk/vim-sneak'                               " Jump to any location specified by two characters
Plug 'junegunn/goyo.vim'                                " Distraction-free writing mode
Plug 'tmsvg/pear-tree'                                  " Auto complete pairs sensibly
Plug 'mhinz/vim-signify'                                " Display git changes in gutter & status bar
Plug 'machakann/vim-highlightedyank'                    " Make the yanked region apparent!
Plug 'itchyny/lightline.vim'                            " Light and configurable statusline/tabline
Plug 'mengelbrecht/lightline-bufferline'                " Provides bufferline functionality for lightline
Plug 'vimwiki/vimwiki'                                  " Personal wiki
Plug '907th/vim-auto-save'                              " Auto save

" LANGUAGES:
Plug 'sheerun/vim-polyglot'                             " Syntax for various languages
Plug 'arzg/vim-rust-syntax-ext'                         " Enhances Rust syntax highlighting

" COLORS:
Plug 'sainnhe/gruvbox-material'
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'

call plug#end() " Initialize plugin system

" }}}
" Plugin Settings {{{

source $HOME/.config/nvim/plugins/settings/coc.vim
source $HOME/.config/nvim/plugins/settings/fzf.vim
source $HOME/.config/nvim/plugins/settings/goyo.vim
source $HOME/.config/nvim/plugins/settings/gruvbox-material.vim
source $HOME/.config/nvim/plugins/settings/gruvbox.vim
source $HOME/.config/nvim/plugins/settings/lightline.vim
source $HOME/.config/nvim/plugins/settings/pear-tree.vim
source $HOME/.config/nvim/plugins/settings/vim-auto-save.vim
source $HOME/.config/nvim/plugins/settings/vim-highlightedyank.vim
source $HOME/.config/nvim/plugins/settings/vim-signify.vim
source $HOME/.config/nvim/plugins/settings/vimwiki.vim

" }}}
" Editing {{{

set autoindent                    " Indent according to previous line.
set expandtab                     " Use spaces instead of tabs.
set softtabstop=4                 " Tab key indents by 4 spaces.
set shiftwidth=4                  " >> indents by 4 spaces.
set shiftround                    " >> indents to next multiple of 'shiftwidth'.
set wrap                          " Wrap lines
set shiftwidth=4                  " 1 tab == 4 spaces
set tabstop=4                     " for sure.
set incsearch                     " search as characters are entered
set hlsearch                      " highlight matches
set ignorecase                    " Ignore case when searching
set smartcase                     " When searching try to be smart about cases
set clipboard=unnamedplus         " yank to macos clipboard
set mousefocus                    " Focus follows mouse
set timeout                       " Do time out on mappings and others
set ttimeoutlen=0                 " Make escape timeout faster
set timeoutlen=1000               " Wait before timing out a mapping
set wrapscan                      " Searches wrap around end-of-file.
set report=0                      " Always report changed lines.

" Line break on a lot of characters
set lbr
set tw=5000000

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo

" }}}
" UI {{{

" Enable true color
set termguicolors

set background=dark
set t_Co=256

colorscheme gruvbox-material

set showtabline=2     " Show top tab line
set so=10             " How many lines from cursor to top / bottom of the screen before scrolling
set number            " file line numbering
set rnu               " relative line numbers
set showcmd           " show last entered command
set wildmenu          " visual auto complete for command menu
set lazyredraw        " redraw only when needed
set showmatch         " highlight matching [{()}]
set noeb vb t_vb=     " no visual bell or beeping (thank god)
set ruler             " Always show current position
set magic             " For regular expressions turn magic on
set noshowmode        " Remove redundant status bar elements
set foldenable        " Fold code
set foldmethod=marker " Fold code with {{{}}}
set linespace=0       " No extra space between lines
set laststatus=2      " Show statusline
set splitbelow        " Always vertically split below
set splitright        " Always horizontally split to the right
set fillchars+=vert:│ " Change vertical split character to solid line instead of line with gaps
set signcolumn=yes    " Column for git diff
set shortmess+=c      " Don't pass messages to ins-completion-menu.

" Clean up sign column (git gutter)
highlight SignColumn ctermbg=NONE guibg=NONE

" Clean up signify symbol backgrounds in sign column (git gutter)
highlight SignifySignAdd ctermfg=green ctermbg=NONE guibg=NONE
highlight SignifySignDelete ctermfg=red ctermbg=NONE guibg=NONE
highlight SignifySignChange ctermfg=blue ctermbg=NONE guibg=NONE

" }}}
" Binds & Mappings {{{

let mapleader=" " "leader = space

" Navigate to specific numbered buffer
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" Intuitive j/k behavior with wrapping
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" More convenient
nnoremap J }
vnoremap J }
nnoremap K {
vnoremap K {

" Start fzf with ctrl+p
nnoremap <leader>f :Files<CR>

" reload vim configuration
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

 " clear search
nnoremap <silent><leader><space> :let @/ = ""<CR>

" jk is escape
inoremap jk <ESC>

" Remap VIM 0 to first non-blank character
map 0 ^

" unbind annoying help page
nmap <F1> <nop>

" Toggle pastemode
map <silent> <C-p> :set invpaste <CR>

" Toggle goyo
nnoremap <leader>z :Goyo<cr>

" Toggle Spellcheck
noremap <F3> :setlocal spell! spelllang=en_us<CR>

" Insert date / time
nnoremap <leader>id "=strftime(" %a, %b %d %Y")<CR>p
nnoremap <leader>it "=strftime(" %I:%M %p")<CR>p

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open new empty buffer
nnoremap <leader>T :enew<cr>

" Move to the next buffer
nnoremap <leader>m :bnext<CR>
nnoremap <right> :bnext<CR>

" Move to the previous buffer
nnoremap <leader>n :bprevious<CR>
nnoremap <left> :bprevious<CR>

" Split binds
nnoremap <leader>- :split<CR>
nnoremap <leader>\| :vsplit<CR>

" Close window
nnoremap <leader>c :close<CR>

" Close buffer
nnoremap <leader>q :bd<CR>

" Vim plug ease of use bindings
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pc :PlugClean<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Browse git commits with fzf + fugitive
nnoremap <leader>gg :BCommits!<CR>

" Filter lines with search in current buffer
nmap // :BLines!<CR>

" Open coc-explorer
nnoremap <leader>e :CocCommand explorer<CR>

" Quit everything with :q
cmap q qa

fun! StripTrailingWhitespace()
    let l:save = winsaveview()          " Save current window view
    silent keeppatterns %s/\s\+$//e     " Strip trailing whitespace
    call winrestview(l:save)            " Restore window view
    echo "Stripped trailing whitespace"
endfun

cmap stw call StripTrailingWhitespace()

" }}}
