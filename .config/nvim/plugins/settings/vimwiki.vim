" Use markdown for vimwiki
let g:vimwiki_list = [{'path': '~/Exo/', 'syntax': 'markdown', 'ext': '.md'}] 

" Use a template when generating new vimwiki diary files
au BufNewFile ~/Exo/diary/*.md :silent 0r !~/.config/nvim/bin/generate-diary-template '%'
