let g:fzf_layout = {'window': { 'width': 0.6, 'height': 0.8}} " Nice FZF Preview window

" Open FZF with bat preview window (syntax highlighting + more)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', '~/.config/nvim/plugins/installed/fzf.vim/bin/preview.sh {}']}, <bang>0)
