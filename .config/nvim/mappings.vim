" --- Commands
" Bd: buffer delete while keeping current window layout
command Bd bp\|bd \#

" --- MAPS {{{
let mapleader=" "

" Intuitive j/k behavior with wrapping
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Reload vim configuration
" nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

" Save
function! WriteSavePosition()
    let pos = getpos(".")
    :wa
    call setpos('.', pos)
endfunction
" nnoremap <silent><leader>s :silent :call WriteSavePosition()<cr>
" nnoremap <silent><leader>w :w!<cr>
nnoremap <silent><F5> :w!<cr>
" nnoremap <silent><leader>hw :TrimWhitespace<cr>

 " Clear search highlight
nnoremap <silent><leader><space> :let @/ = ""<CR>

" Multifunctional escape!
nnoremap <silent><ESC> :nohlsearch \| :cclose<CR>

" Remap VIM 0 to first non-blank character
nnoremap 0 ^
nnoremap ^ 0

" unbind annoying help page
nmap <F1> <nop>

" Toggle pastemode
nnoremap <silent> <C-p> :set invpaste <CR>

" Insert date / time
nnoremap <leader>id "=strftime("%a, %b %d %Y")<CR>p
nnoremap <leader>it "=strftime("%-I:%M:%S %p")<CR>p
nnoremap <leader>is "=strftime("-- CKF %-I:%M:%S %p")<CR>p

" Dont put change operations into register
nnoremap c "_c
nnoremap C "_C

" Clone paragraph
nnoremap cp vap:t'><CR>

" Paste in insert mode
inoremap <C-v> <C-r>*

" Split binds
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>b :split<CR>

" Close window
" nnoremap <leader>c :close<CR>
nnoremap <C-c> :close<CR>

" Vim plug ease of use bindings
nnoremap <leader>ps :PackerSync<CR>
nnoremap <leader>pc :PackerCompile profile=true<CR>
nnoremap <leader>pC :PackerClean<CR>
nnoremap <leader>pd :PackerProfile<CR>

" Quit everything with :qq / Q
cmap qq qa!
cmap Q qa!
cmap WQ wqa!

" Toggle folds in normal mode with tab
nnoremap <Tab> za

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Replace ex mode with gq (shorten long line)
map Q gq

" Replace all on S
nnoremap <leader>S :%s//g<Left><Left>

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
xnoremap . :norm.<CR>

" Don't yank <CR>
nnoremap Y yg_

" Center cursor when doing jumpy motions
nnoremap n nzzzv
nnoremap N Nzzzv
" nnoremap { {zz
" nnoremap } }zz
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap [j <C-o>zz
nnoremap <C-o> <C-o>zz

" Join current line and next line properly
nnoremap J mzJ`z

" Add undo break points when inserting punctuation
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap [ [<c-g>u
inoremap { {<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Intuitive text movement
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Switch to previous buffer
nnoremap <Backspace> <C-^>

" Better increment/decrement operators
nnoremap + <C-a>
nnoremap - <C-x>

" remove all trailing whitespace with gw
nnoremap gw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

function! CompileProject()
  :w
  echohl SpecialComment
  echo 'Compiling…'
  !./run
endfunction

" TODO: handle project compilation by language
" execute ./run command
nnoremap <F2> <CMD>call CompileProject()<cr>
inoremap <F2> <CMD>call CompileProject()<cr>

" change directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" --- PLUGINS {{{
" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader>pp <cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<cr>
" nnoremap <leader>h <cmd>SessionManager load_session<cr>
nnoremap <leader>wf <cmd>lua require('telescope').extensions.vimwiki.vimwiki({})<cr>
nnoremap <leader>wg <cmd>Telescope vimwiki live_grep<cr>
nnoremap <leader>r <cmd>lua require('telescope').extensions.frecency.frecency()<cr>

vmap <Space> <Nop>

" Neogit
nnoremap <leader>g <cmd>Neogit<cr>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Lightspeed
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

" Save buffer before opening fterm, but not in startup screen
function! OpenTerm()
  if &ft != "alpha"
    exe 'silent :w!'
  endif
  exe 'lua require("FTerm").toggle()'
endfunction
" FTerm
nnoremap <silent> <leader>t <CMD>call OpenTerm()<CR>
nnoremap <silent> <C-t> <CMD>:w<CR><CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <C-t> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <C-q> <CMD>lua require("FTerm").toggle()<CR>
nnoremap <silent> <F3> <CMD>:w<CR><CMD>lua require("FTerm").toggle()<CR>
inoremap <silent> <F3> <CMD>:w<CR><CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <F3> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <ESC> <CMD>lua require("FTerm").toggle()<CR>

" Trouble
nnoremap <leader>d <cmd>TroubleToggle workspace_diagnostics<cr>

" Bufferline
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <leader>h :BufferLineCyclePrev<CR>
nnoremap <leader>l :BufferLineCycleNext<CR>
nnoremap <leader>H :BufferLineMovePrev<CR>
nnoremap <leader>L :BufferLineMoveNext<CR>
" Switch to buffers and save when doing so
" nnoremap <silent><leader>1 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 1<CR>
" nnoremap <silent><leader>2 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 2<CR>
" nnoremap <silent><leader>3 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 3<CR>
" nnoremap <silent><leader>4 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 4<CR>
" nnoremap <silent><leader>5 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 5<CR>
" nnoremap <silent><leader>6 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 6<CR>
" nnoremap <silent><leader>7 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 7<CR>
" nnoremap <silent><leader>8 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 8<CR>
" nnoremap <silent><leader>9 <Cmd>:silent w<CR><Cmd>BufferLineGoToBuffer 9<CR>
" Switch to buffer
nnoremap <silent> <leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent> <leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent> <leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent> <leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent> <leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent> <leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent> <leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent> <leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent> <leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" Bdelete
" default closes buffer while preserving window layout
" nnoremap <silent><leader>q <Cmd>:silent lua require('bufdelete').bufdelete(0, true)<CR>
" intuitive tab change
" nnoremap <silent><leader>q <Cmd>:BufferlineCyclePrev<CR><Cmd>:silent lua require('bufdelete').bufdelete(0, true)<CR>

" a little more intuitive, but breaks when changes are mad to tabline with leader-H & L
" nnoremap <silent><leader>q <Cmd>:Bdelete<CR><Cmd>:bp<CR>
nnoremap <silent><leader>q <Cmd>:Bdelete<CR>

" Tree
nnoremap <C-e> :NvimTreeToggle<CR>
nnoremap <leader>e :NvimTreeToggle<CR>

" TrueZen
nnoremap <leader>zz <cmd>:silent TZAtaraxis<cr>
nnoremap <leader>we <cmd>:silent TZAtaraxis<cr>
nnoremap <silent><F4> <cmd>:silent TZAtaraxis<cr>

" Vimwiki
" unmap this, as it overrides my <BS> map
nmap <F21> <Plug>VimwikiGoBackLink


" Sniprun
nmap <silent> <leader>cr :lua require'sniprun'.run()<CR>
vmap <silent> <leader>cr :lua require'sniprun'.run()<CR>
nmap <leader>cx <Cmd>:SnipReset<CR> 
nmap <leader>cc <Plug>SnipClose

