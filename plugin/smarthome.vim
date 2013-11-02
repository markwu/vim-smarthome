" Reference: http://vim.wikia.com/wiki/SmartHome_and_SmartEnd_over_wrapped_lines

" if at first word, move to beginning of line
" if at beginning of line, move to beginning of window
" if at beginning of window, move to beginning of file
nnoremap <silent> <kHome> :call SmartHome("n")<CR>
inoremap <silent> <kHome> <C-O>:call SmartHome("i")<CR>
vnoremap <silent> <kHome> <Esc>:call SmartHome("v")<CR>
nnoremap <silent> <Home> :call SmartHome("n")<CR>
inoremap <silent> <Home> <C-O>:call SmartHome("i")<CR>
vnoremap <silent> <Home> <Esc>:call SmartHome("v")<CR>
function! SmartHome(mode)
    if col('.') == 1
        if line('.') == 1
            return
        elseif winline() == &scrolloff+1
            normal! m`gg
        else
            normal! m`H0
        endif
    elseif strpart(getline('.'), -1, col('.')) =~ '^\s\+$'
        normal! 0
    else
        normal! ^
    endif
    if a:mode == "v"
        normal! msgv`s
    endif
endfunction

" map <End> to move to end of line
" if at end of line, move to end of window
" if at end of window, move to end of file
nnoremap <silent> <kEnd> :call SmartEnd("n")<CR>
inoremap <silent> <kEnd> <C-O>:call SmartEnd("i")<CR>
vnoremap <silent> <kEnd> <Esc>:call SmartEnd("v")<CR>
nnoremap <silent> <End> :call SmartEnd("n")<CR>
inoremap <silent> <End> <C-O>:call SmartEnd("i")<CR>
vnoremap <silent> <End> <Esc>:call SmartEnd("v")<CR>
function! SmartEnd(mode)
    normal yl
    let l:charlen = byteidx(getreg(), 1)
    if col('.') < col('$')-l:charlen
        normal! $
    elseif winline() < winheight(0) - &scrolloff
        normal! m`L$
    else
        normal! m`G$
    endif
    if a:mode == "v"
        normal! msgv`s
    endif
endfunction
