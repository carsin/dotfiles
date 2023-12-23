" compile project
nnoremap <silent> <F1> :w<CR>:AsyncRun -cwd=<root> make <CR>
" run project 
nnoremap <silent> <F2> :lua require('FTerm').scratch({ cmd = 'make run' })<CR>
" compile & run project 
nnoremap <silent> <F3> :lua require('FTerm').scratch({ cmd = 'make && make run' })<CR>
