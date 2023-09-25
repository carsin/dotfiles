" General {{{
language en_US.utf8
set nocompatible

filetype plugin indent on " Load plugins according to detected filetype.
syntax on                 " Enable syntax highlighting.

if has('termguicolors')
    set termguicolors
endif

set title            " report title to terminal
set history=500      " How many lines of history vim has to remember
set encoding=utf8    " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac " Use Unix as the standard file type
set updatetime=250   " Time before plugins and inserthold is fired
set mouse=a          " Set proper mouse mode

" Turn swap off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

" chdir
" set autochdir

" Check file change and reload the buffer upon detection
set autoread
au CursorHold * checktime

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" }}}

" Plugins settings {{{
" Misc vim settings
let g:loaded_matchit = 1
" TODO: Move this
let g:undotree_WindowLayout = 3 " diff on bot tree on right
" e.g. using 'd' instead of 'days' to save some space.
let g:undotree_ShortIndicators = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 40
let g:undotree_DiffpanelHeight = 13
" targets use builtins if one exists
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab lB Ar aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA'

" automatically open quickfix window when AsyncRun command is executed
let g:asyncrun_open = 9 " set the quickfix window height
" let g:asyncrun_bell = 1 " ring the bell to notify you job finished
let g:asyncrun_auto = "make" " trigger QuickFixCmdPost to process content in quickfix
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml', 'Makefile']

" setup colorscheme
let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_show_eob = 0
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_visual = 'reverse'
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
let g:gruvbox_material_palette = 'original' " I prefer the vibrancy of the original
let g:gruvbox_material_better_performance = 1

" matchup + tpope surround
let g:matchup_surround_enabled = 1

" colorscheme gruvbox-material
" Load plugins
let mapleader=" "
lua require('init')
" Load lua commands
" lua require('commands')

" augroup jdtls_lsp
"     autocmd!
"     autocmd FileType java lua require("jdtls").start_or_attach(require'settings.lsp.jdtls'.config)
" augroup end

" }}}

" Editing
set autoindent                    " Indent according to previous line.
set expandtab                     " Use spaces instead of tabs.
set softtabstop=4                 " Tab key indents by 4 spaces.
set shiftwidth=4                  " >> indents by 4 spaces.
set shiftround                    " >> indents to next multiple of 'shiftwidth'.
set wrap                          " Wrap lines
" set nowrap                        " noWrap lines
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
set timeoutlen=600                " Wait before timing out a mapping
set wrapscan                      " Searches wrap around end-of-file.
set report=0                      " Always report changed lines.
set lbr                           " Break by word rather than character
set fo+=ltnp                      " formatoptions
set fo-=ro                        " no annoying comment autoformat
set tw=80                         " Lines should be 80 chars
set nrformats=                    " Force decimal based arithmetic
set nolist                        " ensure lbr  works
set backspace=eol,start,indent    " Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l "          " go to nextline with hl
set wrapmargin=2
set sessionoptions-=folds         " ensure sessions don't override default method of buffer
" Enable persistent undo so that undo history persists across vim sessions
if has("persistent_undo")
   let target_path = expand('~/.cache/nvim/undo')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

set backup
set backupdir=~/.cache/nvim/backup

" Disables automatic commenting on newline: autocmd FileType * setlocal
" formatoptions-=c formatoptions-=r formatoptions-=o

" Delete trailing whitespace
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
    echo 'Trimmed trailing whitespace!'
endfun
command! TrimWhitespace call TrimWhitespace()

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" always open quickfix to size and don't jump the newly opened buffer
augroup quickfixsize
    autocmd QuickFixCmdPre * let g:mybufname=bufname('%')
    autocmd QuickFixCmdPost * botright copen 9 | exec bufwinnr(g:mybufname) . 'wincmd w'
augroup END

" filetype stuff
autocmd FileType make setlocal noexpandtab
" autocmd FileType markdown setlocal fo+=a
autocmd FileType gitcommit setlocal spell

" }}}
" UI {{{

" Enable true color
set background=dark

" set t_Co=256
set showtabline=0        " No show top tab line
set nocursorline         " No laggy bar causing many redraws
set so=7                 " How many lines from cursor to top / bottom of the screen before scrolling
set number               " file line numbering
set showcmd              " show last entered command
set wildmenu             " visual auto complete for command menu
set lazyredraw           " redraw only when needed
set showmatch            " highlight matching [{()}]
set noeb vb t_vb=        " no visual bell or beeping
set ruler                " Always show current position
set magic                " For regular expressions turn magic on
set noshowmode           " Remove redundant status bar elements
set foldenable           " autofold code
" set nofoldenable       " Don't autofold code
set foldlevel=99         " Don't autofold past a certain ident level
set linespace=0          " No extra space between lines
set laststatus=3         " Show statusline
set splitbelow           " Always vertically split below
set splitright           " Always horizontally split to the right
set fillchars+=vert:│    " Change vertical split character to solid line instead of line with gaps
set shortmess+=W         " Don't pass messages to ins-completion-menu.
set formatoptions-=cro   " Disable auto insert comment
set signcolumn=yes:1     " Column for diagnostics & git gutter
set pumheight=22         " Shorten number of autocomplete suggestions
set pumwidth=15          " Shorten width of autocomplete suggestions
set pumblend=0           " Autocomplete background transparency
set viewoptions-=options " storing local options in view session files causes no end of trouble
set cmdheight=0          " hide cmdbar when unneeded
let &fcs='eob: '         " No fugly eob tildas
" link/ shortening
" set conceallevel=2
" set concealcursor=nc
" set colorcolumn=80   " 80 char column guide
" set winwidth=80
" set winminwidth=30

" Never make windows completely empty
" set winheight=15
" set winminheight=15

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noselect
" Avoid showing extra messages when using completion
set shortmess+=c

" Show / hide cursorline/rnu in normal and insert
augroup dynamicnumbers
  autocmd!
  " autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &ft != "alpha" && &nu                  | set nocursorline | endif
  "
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &ft != "alpha" && &nu && mode() != "i" | set rnu   | set cursorline   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &ft != "alpha" && &nu                  | set nornu | set nocursorline | endif

  " autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &ft != "alpha" && &nu && mode() != "i" | set rnu   | endif
  " autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &ft != "alpha" && &nu                  | set nornu | endif
augroup END

" Fold parsed langs with treesitter
autocmd FileType norg,rust,lua setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()

" Automatically equalize splits when vim is resized
autocmd VimResized * wincmd =

" Don't take up scrollbar with match
let g:matchup_matchparen_offscreen = { 'method': 'popup' }

" Customized version of folded text, idea by
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
fu! CustomFoldText(string) "{{{1
    "get first non-blank line
    let fs = v:foldstart
    if getline(fs) =~ '^\s*$'
      let fs = nextnonblank(fs + 1)
    endif
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif
    let pat  = matchstr(&l:cms, '^\V\.\{-}\ze%s\m')
    " remove leading comments from line
    let line = substitute(line, '^\s*'.pat.'\s*', '', '')
    " remove foldmarker from line
    let pat  = '\%('. pat. '\)\?\s*'. split(&l:fmr, ',')[0]. '\s*\d\+'
    let line = substitute(line, pat, '', '')

"   let line = substitute(line, matchstr(&l:cms,
"	    \ '^.\{-}\ze%s').'\?\s*'. split(&l:fmr,',')[0].'\s*\d\+', '', '')

    let w = get(g:, 'custom_foldtext_max_width', winwidth(0)) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = '+'. v:folddashes
    let lineCount = line("$")
    if has("float")
	try
	    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
	catch /^Vim\%((\a\+)\)\=:E806/	" E806: Using Float as String
	    let foldPercentage = printf("[of %d lines] ", lineCount)
	endtry
    endif
    if exists("*strwdith")
	let expansionString = repeat(a:string, w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    else
	let expansionString = repeat(a:string, w - strlen(substitute(foldSizeStr.line.foldLevelStr.foldPercentage, '.', 'x', 'g')))
    endif
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

set foldtext=CustomFoldText('.')

" }}}
" Binds & Mappings
source ~/.config/nvim/mappings.vim
