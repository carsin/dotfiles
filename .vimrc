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

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set hidden " hide buffers even if they're edited
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

" The fish shell is not very compatible to other shells and unexpectedly breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" }}}
" Plugins {{{

call plug#begin('~/.vim/plugged') " Specify a directory for plugins

Plug 'tpope/vim-sensible' " Defualts everyone can agree on
Plug 'tpope/vim-surround' " Easy matching pairs
Plug 'tpope/vim-fugitive' " Git integration
Plug 'scrooloose/nerdtree' " File tree navigator
Plug 'mattn/emmet-vim' " Emmet integration
Plug 'preservim/nerdcommenter' " Easy commenting
Plug 'jiangmiao/auto-pairs' " Auto pairs
Plug 'Shougo/echodoc.vim' " Displays function signatures from completions in the command line
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete
Plug 'mhinz/vim-startify' " Fancy start page
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  } " Fuzzy file finder
Plug 'airblade/vim-rooter' " Changes Vim working directory to project root
Plug 'vimwiki/vimwiki' " Personal wiki
Plug 'vim-airline/vim-airline' " lean & mean status/tabline
Plug 'unblevable/quick-scope' " highlights a unique character in every word on a line to help you use f
Plug 'chaoren/vim-wordmotion' " better word motions for snake_case and camelCase
Plug 'justinmk/vim-sneak' " jump to any location specified by two characters

Plug 'junegunn/goyo.vim' " Distraction-free writing mode
Plug 'godlygeek/tabular' " Vim script for text filtering and alignment
Plug 'plasticboy/vim-markdown' " Syntax highlighting, matching rules and mappings for the original Markdown and extensions.

" LANGUAGES:
Plug 'sheerun/vim-polyglot' " Syntax for various languages
Plug 'arzg/vim-rust-syntax-ext' " Enhances Rust syntax highlighting

" COLORS:
Plug 'sainnhe/gruvbox-material'
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'

call plug#end() " Initialize plugin system

" }}}
 "Plugin Settings {{{
" CoC {{{
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Makes <cr> select the first completion item, confirm when no item selected, and formats the code:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Disable CoC for certain filetypes
autocmd BufNew,BufEnter *.md,*.txt execute "silent! CocDisable"
autocmd BufLeave *.md,*.txt execute "silent! CocEnable"
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
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
let g:goyo_width= '50%'
" }}}
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close vim if nerdtree is the only window left

let g:airline#extensions#tabline#enabled = 1 " Enable tab line buffer display
let g:airline#extensions#tabline#formatter = 'unique_tail' " Better tab line buffer format

" Use a template when generating new vimwiki diary files
au BufNewFile ~/vimwiki/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'

" Use markdown for vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Configure gruvbox colorscheme
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_statusline_style = 'default'
let g:gruvbox_material_palette = 'original'

let g:gruvbox_contrast_dark = 'hard'

" Don't let vimwiki change .md filetypes
autocmd FileType vimwiki set ft=markdown

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 3
let g:vim_markdown_toc_autofit = 1

" }}}
" Editing {{{

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop=4         " Tab key indents by 4 spaces.
set shiftwidth=4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
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

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespace on save

set mousefocus " Focus follows mouse

set timeout " Do time out on mappings and others
set ttimeoutlen=0 " Make escape timeout faster
set timeoutlen=1000 " Wait {num} ms before timing out a mapping

set wrapscan               " Searches wrap around end-of-file.
set report=0               " Always report changed lines.

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

colorscheme gruvbox-material

let &t_EI .= "\<Esc>[0 q"
let &t_SI .= "\<Esc>[6 q"

set so=7 " How many lines from cursor to top / bottom of the screen before scrolling
set number " line numbering
set rnu
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

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" }}}
" Binds & Mappings {{{

" Intuitive j/k behavior with wrapping
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Open nerd tree
map <C-n> :NERDTreeToggle<CR>

let mapleader=" " "leader = space

" Start fzf with ctrl+p
nnoremap <C-p> :<C-u>FZF<CR>

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

" Toggle pastemode
nnoremap <silent><leader>tp :set invpaste <CR>

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

" Open new empty buffer
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>n :bnext<CR>

" Move to the previous buffer
nmap <leader>p :bprevious<CR>

" Split binds
nmap <leader>- :split<CR>
nmap <leader>\| :vsplit<CR>

nmap <leader>\| :vsplit<CR>

" Change size of vim splits with alt+,/.
execute "set <a-,>=\<esc>,"
execute "set <a-.>=\<esc>."
nnoremap <silent> <a-,> :<c-u>vert res -<c-r>=v:count?v:count1:5<cr><cr>
nnoremap <silent> <a-.> :<c-u>vert res +<c-r>=v:count?v:count1:5<cr><cr>

" Open git status in fugitive
nmap <leader>gs :G<CR>

" Vim plug ease of use bindings
nmap <leader>ii :PlugInstall<CR>
nmap <leader>ic :PlugClean<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" }}}
