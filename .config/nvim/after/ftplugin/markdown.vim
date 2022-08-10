nnoremap <buffer> gx :<C-u>call markdown#checkbox#toggle()<CR>
nnoremap <buffer> gX :<C-u>call markdown#checkbox#remove()<CR>
" nmap <buffer> <C-Space> :<C-u>call markdown#checkbox#toggle()<CR>
" nmap <buffer> <C-S-Space> :<C-u>call markdown#checkbox#remove()<CR>
" nmap <buffer> <C-Space> :<C-u>call markdown#checkbox#toggle()<CR>
" nmap <buffer> <C-S-Space> :<C-u>call markdown#checkbox#remove()<CR>

" Custom markdown folding: fold by headers
function MarkdownLevel()
  let h = matchstr(getline(v:lnum), '^#\+')
  if empty(h)
    return "="
  else
    return ">" . len(h)
  endif
endfunction

function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2" endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "="
endfunction
au BufEnter *.md setlocal foldmethod=expr foldexpr=MarkdownLevel() wrap lbr tw=80

" ensure folds aren't changed when inserting/pasting/modifying text
" augroup folds
"   au!
"   au InsertEnter * let w:oldfdm = &l:foldmethod | setlocal foldmethod=manual
"   au InsertLeave *
"         \ if exists('w:oldfdm') |
"         \   let &l:foldmethod = w:oldfdm |
"         \   unlet w:oldfdm |
"         \ endif |
"         \ normal! zv
" augroup END
