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

set updatetime=1000        " Fast updatetime for snappier experience

" Set proper mouse mode
set mouse=a
" set ttymouse=xterm2

" The fish shell is not very compatible to other shells and unexpectedly breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

" }}}
" Plugins {{{
call plug#begin('~/.config/nvim/plugged') " Specify a directory for plugins

Plug 'tpope/vim-surround'                               " Commands for matching & surrounding pairs
Plug 'tpope/vim-commentary'                             " Simply toggle comments with gc
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Autocomplete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Fuzzy file finder
Plug 'junegunn/fzf.vim'                                 " fzf based commands and mappings
Plug 'airblade/vim-rooter'                              " Changes Vim working directory to project root
Plug 'unblevable/quick-scope'                           " Highlights a unique character in every word on a line to help you use f
Plug 'chaoren/vim-wordmotion'                           " Better word motions for snake_case and camelCase
Plug 'justinmk/vim-sneak'                               " Jump to any location specified by two characters
Plug 'junegunn/goyo.vim'                                " Distraction-free writing mode
Plug 'godlygeek/tabular'                                " Vim script for text filtering and alignment
Plug 'plasticboy/vim-markdown'                          " Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
Plug 'tmsvg/pear-tree'                                  " Auto complete pairs sensibly
Plug 'mhinz/vim-signify'                                " Display git changes in gutter & status bar
Plug 'machakann/vim-highlightedyank'                    " Make the yanked region apparent!
Plug 'itchyny/lightline.vim'                            " Light and configurable statusline/tabline
Plug 'mengelbrecht/lightline-bufferline'                " Provides bufferline functionality for lightline
Plug 'tpope/vim-fugitive'                               " A Git wrapper so awesome, it should be illegal
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

" Don't load CoC immediately
augroup LazyLoadCoc
    autocmd!
    autocmd InsertEnter * call plug#load('coc.nvim')
augroup END

" }}}
" Plugin Settings {{{
" TODO: Put plugin specific configuration in seperate file then source into main
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

let g:goyo_height = '100%'
let g:goyo_width= '40%'

" }}}
" Lightline {{{
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#unnamed      = '[Unnamed]'
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ]
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [['lineinfo'],
      \             ['percent'],
      \             [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
" }}}

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_postsave_hook = 'call StripTrailingWhitespace()'

let g:signify_sign_add = '+'
let g:signify_sign_delete = '─'
let g:signify_sign_change = '~'

let g:pear_tree_repeatable_expand = 0 " Make pair expansion not weird
" Make pear tree smart
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1

let g:fzf_layout = {'window': { 'width': 0.6, 'height': 0.8}} " Nice FZF Preview window

let g:highlightedyank_highlight_duration = 150

" Configure gruvbox colorscheme
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_statusline_style = 'default'
let g:gruvbox_material_palette = 'original'
let g:gruvbox_contrast_dark = 'hard'

let g:vimwiki_list = [{'path': '~/exo/', 'syntax': 'markdown', 'ext': '.md'}] " Use markdown for vimwiki

" Proper folding defaults in vimwiki
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 3
let g:vim_markdown_toc_autofit = 1

" Open FZF with bat preview window (syntax highlighting + more)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

" Use a template when generating new vimwiki diary files
au BufNewFile ~/exo/diary/*.md :silent 0r !~/.config/nvim/bin/generate-diary-template '%'
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
set clipboard=unnamed             " yank across instances
set mousefocus                    " Focus follows mouse
set timeout                       " Do time out on mappings and others
set ttimeoutlen=0                 " Make escape timeout faster
set timeoutlen=1000               " Wait {num} ms before timing out a mapping
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

" Auto save buffer
" autocmd TextChanged,InsertLeave,WinLeave,FocusLost <buffer> :call Save()

" fun! Save()
"     let l:save = winsaveview()          " Save current window view
"     silent keeppatterns %s/\s\+$//e     " Strip trailing whitespace
"     call winrestview(l:save)            " Restore window view
"     silent write                        " Save
" endfun

fun! StripTrailingWhitespace()
    let l:save = winsaveview()          " Save current window view
    silent keeppatterns %s/\s\+$//e     " Strip trailing whitespace
    call winrestview(l:save)            " Restore window view
    " echo "Trailing whitespace stripped"
endfun

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

" let &t_EI .= "\<Esc>[0 q"
" let &t_SI .= "\<Esc>[6 q"

set showtabline=2
set so=7              " How many lines from cursor to top / bottom of the screen before scrolling
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

" Clean up sign column (git gutter)
highlight SignColumn ctermbg=NONE guibg=NONE

" Clean up signify symbol backgrounds in sign column (git gutter)
highlight SignifySignAdd ctermfg=green ctermbg=NONE guibg=NONE
highlight SignifySignDelete ctermfg=red ctermbg=NONE guibg=NONE
highlight SignifySignChange ctermfg=blue ctermbg=NONE guibg=NONE

" Show non-printable characters
set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

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
nnoremap K {

" Proper indentation when moving lines in visual mode
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

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
nnoremap <leader>id "=strftime("%a, %b %d %Y")<CR>p
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

" Change size of vim splits with alt+,/.
" execute "set <a-,>=\<esc>,"
" execute "set <a-.>=\<esc>."
" nnoremap <silent> <a-,> :<c-u>vert res -<c-r>=v:count?v:count1:5<cr><cr>
" nnoremap <silent> <a-.> :<c-u>vert res +<c-r>=v:count?v:count1:5<cr><cr>

" Vim plug ease of use bindings
nnoremap <leader>ii :PlugInstall<CR>
nnoremap <leader>ic :PlugClean<CR>

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

" }}}
