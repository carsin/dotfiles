" Use markdown for vimwiki
let g:vimwiki_list = [{'path': '~/Exo/', 'syntax': 'markdown', 'ext': '.md', 'diary_index': 'index', 'diary_rel_path': 'log/', 'diary_header': 'Daily Log', 'auto_diary_index': 1}] 

" Use a template when generating new vimwiki diary files
au BufNewFile ~/Exo/log/*.md :silent 0r !~/.config/nvim/bin/generate-diary-template '%'

