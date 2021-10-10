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
nnoremap <silent><leader>s :silent :call WriteSavePosition()<cr>

 " Clear search highlight
nnoremap <silent><leader><space> :let @/ = ""<CR>

" Multifunctional escape!
nnoremap <silent><ESC> :nohlsearch \| :cclose<CR>

" Remap VIM 0 to first non-blank character
map 0 ^

" unbind annoying help page
nmap <F1> <nop>

" Toggle pastemode
nnoremap <silent> <C-p> :set invpaste <CR>

" Insert date / time
nnoremap <leader>id "=strftime("%a, %b %d %Y")<CR>p
nnoremap <leader>it "=strftime("%I:%M %p")<CR>p

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
nnoremap <leader>c :close<CR>

" Vim plug ease of use bindings
nnoremap <leader>ps :PackerSync<CR>
nnoremap <leader>pc :PackerCompile<CR>

" Quit everything with :q
cmap q qa

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

" --- PLUGINS {{{
" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
" nnoremap <leader>o <cmd>Telescope buffers<cr>
nnoremap <leader>pp <cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<cr>
" nnoremap <leader>h <cmd>telescope help_tags<cr>
nnoremap <leader>ws <cmd>lua require('telescope').extensions.vimwiki.vimwiki()<cr>

" easyalign
xmap ga <plug>(easyalign)
nmap ga <plug>(easyalign)

" lightspeed
nmap <expr> f reg_recording() . reg_executing() == "" ? "<plug>lightspeed_f" : "f"
nmap <expr> f reg_recording() . reg_executing() == "" ? "<plug>lightspeed_f" : "f"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<plug>lightspeed_t" : "t"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<plug>lightspeed_t" : "t"

" fterm
nnoremap <silent> <leader>t <cmd>lua require("fterm").toggle()<cr>
nnoremap <silent> <c-t> <cmd>lua require("fterm").toggle()<cr>
tnoremap <silent> <c-t> <cmd>lua require("fterm").toggle()<cr>
tnoremap <silent> <c-q> <cmd>lua require("fterm").toggle()<cr>
nnoremap <silent> <f3> <cmd>lua require("fterm").toggle()<cr>
tnoremap <silent> <f3> <cmd>lua require("fterm").toggle()<cr>
tnoremap <silent> <esc> <cmd>lua require("fterm").toggle()<cr>

" trouble
nnoremap <leader>xx <cmd>troubletoggle<cr>
nnoremap <leader>xw <cmd>troubletoggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>troubletoggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>troubletoggle quickfix<cr>
nnoremap <leader>xl <cmd>troubletoggle loclist<cr>
" nnoremap gr <cmd>troubletoggle lsp_references<cr>

" bufferline
nnoremap <leader>l :bufferlinecyclenext<cr>
nnoremap <leader>h :bufferlinecycleprev<cr>
nnoremap <silent>[b :bufferlinecycleprev<cr>
nnoremap <silent>]b :bufferlinecyclenext<cr>
nnoremap <leader>h :bufferlinemoveprev<cr>
nnoremap <leader>l :bufferlinemovenext<cr>
nnoremap <silent><leader>1 <cmd>bufferlinegotobuffer 1<cr>
nnoremap <silent><leader>2 <cmd>bufferlinegotobuffer 2<cr>
nnoremap <silent><leader>3 <cmd>bufferlinegotobuffer 3<cr>
nnoremap <silent><leader>4 <cmd>bufferlinegotobuffer 4<cr>
nnoremap <silent><leader>5 <cmd>bufferlinegotobuffer 5<cr>
nnoremap <silent><leader>6 <cmd>bufferlinegotobuffer 6<cr>
nnoremap <silent><leader>7 <cmd>bufferlinegotobuffer 7<cr>
nnoremap <silent><leader>8 <cmd>bufferlinegotobuffer 8<cr>
nnoremap <silent><leader>9 <cmd>bufferlinegotobuffer 9<cr>

nnoremap <silent><leader>q <CMD>lua require('bufdelete').bufdelete(0, true)<CR>

" Tree
nnoremap <C-e> :NvimTreeToggle<CR>
nnoremap <leader>e :NvimTreeToggle<CR>
