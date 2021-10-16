" General {{{

set nocompatible

filetype plugin indent on " Load plugins according to detected filetype.
syntax on                 " Enable syntax highlighting.

set title            " report title to terminal
set hidden           " hide buffers even if they're edited
set history=500      " How many lines of history vim has to remember
set encoding=utf8    " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac " Use Unix as the standard file type
set updatetime=150   " Fast updatetime for snappier experience
set mouse=a          " Set proper mouse mode

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

" Load plugins

let g:vimwiki_list = [{'path': '~/files/text/wiki', 'syntax': 'markdown', 'ext': '.md', 'diary_index': 'diary', 'diary_rel_path': '/', 'diary_header': 'Daily Log', 'auto_diary_index': 1}]
au BufNewFile ~/files/text/wiki/*.md :silent 0r !~/.config/nvim/bin/journal-template.py '%'
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'run', '.classpath']
lua require'plugins'

" Editing
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
set timeoutlen=500                " Wait before timing out a mapping
set wrapscan                      " Searches wrap around end-of-file.
set report=0                      " Always report changed lines.
set lbr                           " Break at end of line
set tw=80                         " Lines should be 80 chars
set nrformats=                    " Force decimal based arithmetic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.cache/nvim/undo

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Delete trailing whitespace
function! StripTrailingWhitespace()
  if &modifiable
    normal mZ
    let l:chars = col("$")
    %s/\s\+$//e
    normal `Z
  endif
endfunction

autocmd CursorHold * call StripTrailingWhitespace()

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" }}}
" UI {{{

" Enable true color
set termguicolors

set background=dark
" set t_Co=256

let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_show_eob = 0
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_visual = 'reverse'
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
let g:gruvbox_material_palette = 'original' " I prefer the vibrancy of the original
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material

set showtabline=2      " Show top tab line
set so=7               " How many lines from cursor to top / bottom of the screen before scrolling
set number             " file line numbering
set showcmd            " show last entered command
set wildmenu           " visual auto complete for command menu
set lazyredraw         " redraw only when needed
set showmatch          " highlight matching [{()}]
set noeb vb t_vb=      " no visual bell or beeping
set ruler              " Always show current position
set magic              " For regular expressions turn magic on
set noshowmode         " Remove redundant status bar elements
" set nofoldenable       " Don't autofold code
set foldlevel=99       " Don't autofold past a certain ident level
set linespace=0        " No extra space between lines
set laststatus=2       " Show statusline
set splitbelow         " Always vertically split below
set splitright         " Always horizontally split to the right
set fillchars+=vert:│  " Change vertical split character to solid line instead of line with gaps
set shortmess+=W       " Don't pass messages to ins-completion-menu.
set formatoptions-=cro " Disable auto insert comment
set signcolumn=yes:1   " Column for diagnostics & git gutter
set pumheight=20       " Shorten number of autocomplete suggestions
set pumwidth=20       " Shorten number of autocomplete suggestions
set pumblend=10        " Autocomplete background transparency
let &fcs='eob: '       " No idiotic eob tildas
" set colorcolumn=80   " 80 char column guide
" set winwidth=80
" set winminwidth=30

" Never make windows completely empty
" set winheight=15
" set winminheight=15

" Show line diagnostics on hover
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({border="none", focusable=false})

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect
" Avoid showing extra messages when using completion
set shortmess+=c

" Fold with treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Only show relative numbers in focused normal mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | set cursorline   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | set nocursorline | endif
augroup END

" Highlight yank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=150}
augroup END

" Automatically equalize splits when vim is resized
autocmd VimResized * wincmd =

augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

" Don't take up scrollbar with match
" let g:matchup_matchparen_offscreen = { 'method': 'popup' }

" }}}
" Binds & Mappings
source ~/.config/nvim/mappings.vim
