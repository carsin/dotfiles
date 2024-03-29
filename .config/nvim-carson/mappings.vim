" --- Commands
" Bd: buffer delete while keeping current window layout
command Bd bp\|bd \#

command FocusDaily ZkNew { dir = 'log' }|silent TZAtaraxis

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
nnoremap <leader>ww :wa!<cr>
nnoremap <leader>ws :w!<cr>
" nnoremap <silent><leader>hw :TrimWhitespace<cr>

 " Clear search highlight
nnoremap <silent><leader><space> :let @/ = ""<CR>

" Multifunctional escape! (close popup windows & clear search hl)
nnoremap <silent><ESC> :nohlsearch \| :cclose<CR>

" Remap VIM 0 to first non-blank character
nnoremap 0 ^
nnoremap ^ 0

" unbind annoying help page
nmap <F1> <nop>
" unbind annoying gQ
nmap gQ <nop>

" Toggle pastemode
nnoremap <silent> <C-p> :set invpaste <CR>

" Insert date / time
nnoremap <leader>id "=strftime("%a, %b %d %Y")<CR>p
nnoremap <leader>it "=strftime("%I:%M:%S %p")<CR>p
nnoremap <leader>is "=strftime("-- CKF %-I:%M:%S %p")<CR>p
" wiki entries
nnoremap <leader>ie o<ESC>"=strftime("### %I:%M:%S %p")<CR>po
nnoremap <leader>ih o<ESC>"=strftime("### %I:%M:%S %p")<CR>po

" Open URI under cursor with lua function
nnoremap gu :OpenURIUnderCursor<CR>
nnoremap <Leader>gu :OpenURIUnderCursor<CR>

" Dont put change operations into register
nnoremap c "_c
nnoremap C "_C

" Clone paragraph
nnoremap cp vap:t'><CR>

" Paste in insert mode
inoremap <C-v> <C-r>*

" Split binds
nnoremap <leader>v :vsplit<CR>
nnoremap <silent> <C-v> :vsplit<CR>
" nnoremap <leader>b :split<CR>
nnoremap <silent> <C-b> :split<CR>

" Close window
" nnoremap <leader>c :close<CR>
nnoremap <C-c> :close<CR>

" Package management ease of use bindings
nnoremap <leader>ps :Lazy update<CR>
" nnoremap <leader>ps :PackerSync<CR>
" nnoremap <leader>pc :PackerCompile profile=true<CR>
" nnoremap <leader>pC :PackerClean<CR>
" nnoremap <leader>pd :PackerProfile<CR>

" Quit everything with :qq / Q
cmap qq qa!
" cmap Q qa!
cmap QQ qa!
cmap Qq qa!
cmap qQ qa!
cmap WQ wqa!

" Toggle folds in normal mode with tab
nnoremap <Tab> za

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Replace ex mode with gq (shorten long line)
" nmap Q gq

" format 80 line limit
" vnoremap gz :s/\v(.{80})/\1\r/g<CR>

" show 80 line charcolumn
inoremap <silent> <F9> <ESC>:execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>a
nnoremap <silent> <F9> :execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>


" Replace all on S
nnoremap <leader>R :%s//g<Left><Left>
vnoremap <leader>R :s//g<Left><Left>

" format to 80 chars with gq in markdown
" autocmd FileType markdown nnoremap gz :%s/.\{80}\($\)\@!/&\r/g<CR>
" autocmd FileType markdown nnoremap gz :%s/\v(.{80}.{-}\s)/\1\r/g<CR>

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
xnoremap . :norm.<CR>

" Don't yank <CR>
nnoremap Y yg_

" Center cursor when doing jumpy motions
" nnoremap n nzzzv
" nnoremap N Nzzzv
" nnoremap { {zz
" nnoremap } }zz
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap [j <C-o>zz
nnoremap <C-o> <C-o>zz
" nmap <C-d> <C-d>zz nmap <C-u> <C-u>zz

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

" Format (selected) paragraph to 80 character lines.
nnoremap <Leader>cf gqap<ESC>
xnoremap <Leader>cf gqa<ESC>
nnoremap <Leader>zp gqap<ESC>
xnoremap <Leader>zp gqa<ESC>


" Switch to previous buffer
nnoremap <Backspace> <C-^>

" Better increment/decrement operators
noremap! <C-h> <C-w>

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
" nnoremap <F2> <CMD>call CompileProject()<cr>
" inoremap <F2> <CMD>call CompileProject()<cr>

" change directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"  delete current file without removing buffer data (useful for restoration)
" nnoremap <leader>zx :call delete(expand('%:p'))\|bd!<CR>

" no more fatfingering and removing visual selection
vmap <Space> <Nop>

" markdown checkboxes toggling
command! -nargs=1 -complete=command StayWinToggle call <SID>StayWinToggle(<f-args>)
function! s:StayWinToggle(cmd) range
  let view = winsaveview()
  execute a:cmd
  call winrestview(view)
endfunction

" toggle progress
autocmd FileType markdown nnoremap <buffer> <silent> - :StayWinToggle keeppatterns s/^\s*-\s*\[\zs.\ze\]/\=get({' ': '.', '.': 'o', 'o': 'X', 'X': ' '}, submatch(0), ' ')/e<cr>
autocmd FileType markdown nnoremap <buffer> <silent> <leader><leader> :StayWinToggle keeppatterns s/^\s*-\s*\[\zs.\ze\]/\=get({' ': '.', '.': 'o', 'o': 'X', 'X': ' '}, submatch(0), ' ')/e<cr>
" toggle completion
autocmd FileType markdown nnoremap <buffer> <silent> <leader><S-Space> :StayWinToggle keeppatterns s/^\s*-\s*\[\zs.\ze\]/\=get({' ': 'X', '~': 'X', '.': 'X', 'o': 'X', 'X': ' '}, submatch(0), ' ')/e<cr>
autocmd FileType markdown nnoremap <buffer> <silent> _ :StayWinToggle keeppatterns s/^\s*-\s*\[\zs.\ze\]/\=get({' ': 'X', '~': 'X', '.': 'X', 'o': 'X', 'X': ' '}, submatch(0), ' ')/e<cr>

" --- PLUGINS {{{

" Vim fugitive - git handler
" nnoremap <leader>gg <cmd>G<cr>
" nnoremap <leader>gl <cmd>Gclog<cr>
" nnoremap <leader>ge <cmd>Gedit<cr>
" nnoremap <leader>gd <cmd>Gdiff<cr>

" EasyAlign
" xmap ga <Plug>(EasyAlign)
" nmap ga <Plug>(EasyAlign)

" Lightspeed jetpack
" nmap s <Plug>Lightspeed_omni_s
" cross window navigation
" nmap gs <Plug>Lightspeed_omni_gs
" nmap gS <Plug>Lightspeed_omni_gS
" inline f/t replacer


" Save buffer before opening fterm, but not in startup screen
function! OpenTerm()
  if &ft != "alpha"
    exe 'silent :w!'
  endif
  exe 'lua require("FTerm").toggle()'
endfunction

" FTerm
" compile
" nmap <F2> <cmd>w<CR><CMD>lua require('FTerm').scratch({ cmd = './run' })<cr>
" imap <F2> <cmd>w<CR><CMD>lua require('FTerm').scratch({ cmd = './run' })<cr>
" nnoremap <leader>oo <CMD>lua __fterm_ranger()<cr>

" Trouble
" nnoremap <leader>d <cmd>TroubleToggle workspace_diagnostics<cr>

" Bufferline
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <silent>[B :BufferLineMovePrev<CR>
nnoremap <silent>]B :BufferLineMoveNext<CR>
nnoremap <leader>h :BufferLineCyclePrev<CR>
nnoremap <leader>l :BufferLineCycleNext<CR>
nnoremap <leader>H :BufferLineMovePrev<CR>
nnoremap <leader>L :BufferLineMoveNext<CR>
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
nnoremap <silent><leader>q <Cmd>:Bdelete<CR><Cmd>:bp<CR>
" nnoremap <silent><leader>q <Cmd>:silent Bdelete!<CR>

" Sniprun
" nmap <silent> <leader>cr :lua require'sniprun'.run()<CR>
" vmap <silent> <leader>cr :lua require'sniprun'.run()<CR>
" nmap <leader>cR <Cmd>:SnipReset<CR>
" nmap <leader>cc <Plug>SnipClose

" nrpattern
nmap <C-a> <Plug>(PatternIncrement)
nmap <C-x> <Plug>(PatternDecrement)
nmap + <Plug>(PatternIncrement)
nmap _ <Plug>(PatternDecrement)

" neorg
" nnoremap <leader>ogh <Cmd>Neorg workspace home<CR>
" nnoremap <leader>on <Cmd>Neorg workspace notes<CR>
" gtd
" nnoremap <leader>ogg <Cmd>Neorg workspace gtd<CR>
" nnoremap <expr> <leader>ogc exists(":NeorgStart") ? ':NeorgStart silent=true<CR>:Neorg gtd capture<CR>' : ':Neorg gtd capture<CR>'
" nnoremap <expr> <leader>oge exists(":NeorgStart") ? ':NeorgStart silent=true<CR>:Neorg gtd capture<CR>' : ':Neorg gtd edit<CR>'
" nnoremap <expr> <leader>ogt exists(":NeorgStart") ? ':NeorgStart silent=true<CR>:Neorg gtd views<CR>' : ':Neorg gtd views<CR>'
" nnoremap <expr> <leader>ogs exists(":NeorgStart") ? ':NeorgStart silent=true<CR>:Neorg gtd views<CR>' : ':Neorg gtd views<CR>'

" symbol outlines
" nnoremap <leader>co <Cmd>SymbolsOutline<CR>

" asyncrun
" nnoremap <silent> <F10> :call asyncrun#quickfix_toggle(7)<cr>

" dap

" map('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
" map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
" map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
" map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
" map('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
" map('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
" map('n', '<leader>dh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
" map('v', '<leader>dh', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')
" map('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
" map('n', '<leader>duf', \"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
" map('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
" map('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
" map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
" map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')
"
"
" -- nvim-dap-ui
" map('n', '<leader>mui', '<cmd>lua require"dapui".toggle()<CR>')

" harpoon
" nnoremap <C-f> <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
" nnoremap <C-e> <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
" nnoremap <leader>F <cmd>lua require("harpoon.mark").add_file()<cr>
" nnoremap <leader>! <cmd>:lua require("harpoon.ui").nav_file(1)<cr>
" nnoremap <leader>@ <cmd>:lua require("harpoon.ui").nav_file(2)<cr>
" nnoremap <leader># <cmd>:lua require("harpoon.ui").nav_file(3)<cr>
" nnoremap <leader>$ <cmd>:lua require("harpoon.ui").nav_file(4)<cr>
" nnoremap <leader>% <cmd>:lua require("harpoon.ui").nav_file(5)<cr>
" nnoremap <leader>^ <cmd>:lua require("harpoon.ui").nav_file(6)<cr>
" nnoremap <leader>& <cmd>:lua require("harpoon.ui").nav_file(7)<cr>

" color picker
nnoremap <leader>cc <cmd>CccPick<cr>
