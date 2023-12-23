" rust-tools mappings
nnoremap <silent> <leader>cr :lua require('rust-tools.runnables').runnables()<CR>
nnoremap <silent> <leader>cc :lua require('rust-tools.open_cargo_toml').open_cargo_toml()<CR>
" compile project
nnoremap <silent> <F1> :w<CR>:AsyncRun -cwd=<root> -post=silent\ doautocmd\ QuickFixCmdPost\ @ cargo check<CR>
" run project 
nnoremap <silent> <F2> :w<CR>:lua require('FTerm').scratch({ cmd = 'cargo run' })<CR>
