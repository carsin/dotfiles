" compile project
nnoremap <silent> <F1> :w<CR>:AsyncRun -cwd=<root> -post=silent\ doautocmd\ QuickFixCmdPost\ @ go build .<CR>
" run project 
nnoremap <silent> <F2> :w<CR>:lua require('FTerm').scratch({ cmd = 'go run .' })<CR>
