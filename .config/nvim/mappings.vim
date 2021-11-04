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
nnoremap <silent><leader>hs :w<cr>

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

" remove all trailing whitespace with gw
nnoremap gw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" --- PLUGINS {{{
" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
" nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>pp <cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<Cr>
nnoremap <leader>ws <cmd>lua require('telescope').extensions.vimwiki.vimwiki()<cr>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Lightspeed
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

" FTerm
nnoremap <silent> <leader>t <CMD>:w<CR><CMD>lua require("FTerm").toggle()<CR>
nnoremap <silent> <C-t> <CMD>:w<CR><CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <C-t> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <C-q> <CMD>lua require("FTerm").toggle()<CR>
nnoremap <silent> <F3> <CMD>:w<CR><CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <F3> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <ESC> <CMD>lua require("FTerm").toggle()<CR>

" Trouble
nnoremap <leader>d <cmd>TroubleToggle lsp_workspace_diagnostics<cr>

" Bufferline
" nnoremap <leader>l :BufferLineCycleNext<CR>
" nnoremap <leader>h :BufferLineCyclePrev<CR>
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <leader>H :BufferLineMovePrev<CR>
nnoremap <leader>L :BufferLineMoveNext<CR>
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><leader>q <CMD>lua require('bufdelete').bufdelete(0, true)<CR>

" Tree
nnoremap <C-e> :NvimTreeToggle<CR>
nnoremap <leader>e :NvimTreeToggle<CR>

" Spectre
nnoremap <leader>S :lua require('spectre').open()<CR>
