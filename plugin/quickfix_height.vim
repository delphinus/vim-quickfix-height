if exists('g:loaded_quickfix_height')
  finish
endif
let g:loaded_quickfix_height = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:quickfix_height_disabled = get(g:, 'quickfix_height_disabled', 0)
let g:quickfix_min_height = get(g:, 'quickfix_min_height', 3)
let g:quickfix_max_height = get(g:, 'quickfix_max_height', 10)

augroup quickfix-height
  autocmd!
  autocmd WinEnter * if &buftype is# 'quickfix' | call quickfix_height#set() | endif
  autocmd BufWinEnter * if &buftype is# 'quickfix' | call quickfix_height#set() | endif
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
