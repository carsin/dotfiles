" --- MAPS {{{
let mapleader=" "

" Intuitive j/k behavior with wrapping
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Reload vim configuration
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

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
map <silent> <leader>p :set invpaste <CR>

" Toggle Spellcheck
noremap <F3> :setlocal spell! spelllang=en_us<CR>

" Insert date / time
nnoremap <leader>id "=strftime("%a, %b %d %Y")<CR>p
nnoremap <leader>it "=strftime("%I:%M %p")<CR>p

" Open new empty buffer
" nnoremap <leader>T :enew<cr>

" Move to the next buffer
" nnoremap <leader>l :bnext<CR>
nnoremap <right> :bnext<CR>

" Move to the previous buffer
" nnoremap <leader>h :bprevious<CR>
nnoremap <left> :bprevious<CR>

" nnoreSplit binds
nnoremap <leader>wh :split<CR>
nnoremap <leader>wv :vsplit<CR>

" Split navigation
" nmap <leader>h <C-W>h<C-W>_
" nmap <leader>j <C-W>j<C-W>_
" nmap <leader>k <C-W>k<C-W>_
" nmap <leader>l <C-W>l<C-W>_

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

" Don't yank <CR>
nnoremap Y yg_

" Center cursor when doing jumpy motions
nnoremap n nzzzv
nnoremap N Nzzzv
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

" --- PLUGINS {{{
" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>o <cmd>Telescope buffers<cr>
nnoremap <leader>pp <cmd>Telescope projects<cr>
" nnoremap <leader>h <cmd>Telescope help_tags<cr>

" Lightspeed
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

" FTerm
nnoremap <silent> <leader>t <CMD>lua require("FTerm").toggle()<CR>
nnoremap <silent> <C-t> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <C-t> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <C-q> <CMD>lua require("FTerm").toggle()<CR>
nnoremap <silent> <F3> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <F3> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <ESC> <CMD>lua require("FTerm").toggle()<CR>

" Trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gr <cmd>TroubleToggle lsp_references<cr>

" Bufferline
nnoremap <leader>l :BufferLineCycleNext<CR>
nnoremap <leader>h :BufferLineCyclePrev<CR>
nnoremap <silent>[b :BufferLineCyclePrev<CR>
nnoremap <silent>]b :BufferLineCycleNext<CR>
nnoremap <leader>H :BufferLineMovePrev<CR>
nnoremap <leader>L :BufferLineMoveNext<CR>
nnoremap <silent><leader>q <CMD>lua require('bufdelete').bufdelete(0, false)<CR>
nnoremap <silent><leader>bd <CMD>lua require('bufdelete').bufdelete(0, true)<CR>
nnoremap <silent><leader>bw <CMD>lua require('bufdelete').bufwipeout(0)<CR>
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
" "
