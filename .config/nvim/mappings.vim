let mapleader=" "

" Intuitive j/k behavior with wrapping
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Start fzf
" nnoremap <Leader>f :Files<CR>

" Reload vim configuration
nnoremap <leader>r :source ~/.config/nvim/init.vim<CR>

" Save
function! WriteSavePosition()
    let pos = getpos(".")
    :wa
    call setpos('.', pos)
endfunction

nnoremap <silent><leader>w :silent :call WriteSavePosition()<cr>

 " Clear search highlight
nnoremap <silent><leader><space> :let @/ = ""<CR>

" Multifunctional escape!
nnoremap <ESC> :nohlsearch \| :cclose<CR>

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
nnoremap <leader>q :close<CR>

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

" Lexima stuff
let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
" nnoremap <leader>h <cmd>Telescope help_tags<cr>

" Lightspeed
nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

" Floating terminal
nnoremap <silent> <leader>t <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <leader>t <CMD>lua require("FTerm").toggle()<CR>
nnoremap <silent> <F3> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <F3> <CMD>lua require("FTerm").toggle()<CR>
tnoremap <silent> <ESC> <CMD>lua require("FTerm").toggle()<CR>
