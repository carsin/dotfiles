let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#unnamed = '[Unnamed]'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#smart_path = 1

let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ]
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [['lineinfo'],
      \             ['percent'],
      \             [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
