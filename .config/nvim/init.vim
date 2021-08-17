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

set title                 " report title to terminal
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

" Check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" }}}
" Plugins {{{
call plug#begin('~/.config/nvim/plugins/installed')     " Specify a directory for plugins

Plug 'tpope/vim-commentary'                             " Simply toggle comments with gc
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Autocomplete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Fuzzy file finder
Plug 'junegunn/fzf.vim'                                 " fzf based commands and mappings
Plug 'justinmk/vim-sneak'                               " Jump to any location specified by two characters
Plug 'tmsvg/pear-tree'                                  " Auto complete pairs sensibly
Plug 'machakann/vim-highlightedyank'                    " Make the yanked region apparent!
Plug 'itchyny/lightline.vim'                            " Light and configurable statusline/tabline
Plug 'mengelbrecht/lightline-bufferline'                " Provides bufferline functionality for lightline
Plug '907th/vim-auto-save'                              " Auto save
Plug 'qpkorr/vim-bufkill'                               " Keeps split layout intact when closing buffer
Plug 'airblade/vim-rooter'                              " Automatically sets vim working directory to the project root
Plug 'mhinz/vim-startify'                               " Nice looking start screen
Plug 'christoomey/vim-tmux-navigator'                   " Seamlessly navigate between tmux & vim splits

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

" CoC {{{
" Don't load CoC immediately
augroup LazyLoadCoc
    autocmd!
    autocmd InsertEnter * call plug#load('coc.nvim')
augroup END

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Disable CoC for certain filetypes
autocmd BufNew,BufEnter *.md,*.txt execute "silent! CocDisable"
autocmd BufLeave *.md,*.txt execute "silent! CocEnable"
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}
" FZF {{{
let g:fzf_layout = {'window': { 'width': 0.8, 'height': 0.7}} " Nice FZF Preview window

" Open FZF with bat preview window (syntax highlighting + more)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', '~/.config/nvim/plugins/installed/fzf.vim/bin/preview.sh {}']}, <bang>0)
" }}}
" Gruvbox Material {{{
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_statusline_style = 'default'
let g:gruvbox_material_palette = 'original'
" }}}
" Gruvbox {{{
" let g:gruvbox_contrast_dark = 'hard'
" }}}
" Lightline {{{
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#unnamed = '[Unnamed]'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#smart_path = 1

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
" Pear tree {{{
" Make pair expansion not weird
let g:pear_tree_repeatable_expand = 0
" Make pear tree smart
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1
" }}}
" Auto save {{{
let g:auto_save = 1
let g:auto_save_silent = 1
" }}}
" Highlighted yank {{{
let g:highlightedyank_highlight_duration = 150
" }}}

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
set timeoutlen=300                " Wait before timing out a mapping
set wrapscan                      " Searches wrap around end-of-file.
set report=0                      " Always report changed lines.
set lbr                           " Break at end of line
set tw=80                         " Lines should be 80 chars

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.cache/nvim/undo

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Delete trailing whitespace and newlines on save
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

" }}}
" UI {{{

" Enable true color
set termguicolors

set background=dark
set t_Co=256

colorscheme gruvbox-material

set showtabline=2      " Show top tab line
set so=10              " How many lines from cursor to top / bottom of the screen before scrolling
set number             " file line numbering
set showcmd            " show last entered command
set wildmenu           " visual auto complete for command menu
set lazyredraw         " redraw only when needed
set showmatch          " highlight matching [{()}]
set noeb vb t_vb=      " no visual bell or beeping (thank god)
set ruler              " Always show current position
set magic              " For regular expressions turn magic on
set noshowmode         " Remove redundant status bar elements
set foldenable         " Fold code
set foldmethod=marker  " Fold code with {{{}}}
set linespace=0        " No extra space between lines
set laststatus=2       " Show statusline
set splitbelow         " Always vertically split below
set splitright         " Always horizontally split to the right
set fillchars+=vert:│  " Change vertical split character to solid line instead of line with gaps
set shortmess+=c       " Don't pass messages to ins-completion-menu.
set formatoptions-=cro " Disable auto insert comment
set colorcolumn=80     " 80 char column guide

" Only show relative numbers in focused normal mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

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

" Start fzf
nnoremap <C-f> :Files<CR>

" reload vim configuration
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

 " clear search
nnoremap <silent><leader><space> :let @/ = ""<CR>

" jk/kj is escape
inoremap jk <ESC>
inoremap kj <ESC>

" Remap VIM 0 to first non-blank character
map 0 ^

" unbind annoying help page
nmap <F1> <nop>

" Toggle pastemode
map <silent> <C-p> :set invpaste <CR>

" Toggle Spellcheck
noremap <F3> :setlocal spell! spelllang=en_us<CR>

" Insert date / time
nnoremap <leader>id "=strftime("%a, %b %d %Y")<CR>p
nnoremap <leader>it "=strftime("%I:%M %p")<CR>p

" Open new empty buffer
nnoremap <leader>T :enew<cr>

" Move to the next buffer
nnoremap <leader>l :bnext<CR>
nnoremap <right> :bnext<CR>

" Move to the previous buffer
nnoremap <leader>h :bprevious<CR>
nnoremap <left> :bprevious<CR>

" Split binds
nnoremap <leader>hs :split<CR>
nnoremap <leader>vs :vsplit<CR>

" Close window
nnoremap <leader>c :close<CR>

" Close buffer
nnoremap <leader>q :BW<CR>

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
" nnoremap <leader>e :CocCommand explorer<CR>

" Quit everything with :q
cmap q qa

" Toggle folds in normal mode with tab
nnoremap <Tab> za

" Replace default f & t motions with vim-sneak's
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Replace ex mode with gq (shorten long line)
map Q gq

" Replace all on S
nnoremap S :%s//g<Left><Left>

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif
" }}}
