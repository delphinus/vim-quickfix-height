function! quickfix_height#set() abort
  if get(g:, 'quickfix_height_disabled', 0)
    return
  endif
  let [min, max] = quickfix_height#_check_config()
  if max == 0
    return
  endif
  let height = quickfix_height#_calculate(min, max, winwidth(0))
  execute height . 'wincmd _'
endfunction

function! quickfix_height#_calculate(min, max, winwidth) abort
  let line = 1
  let line_count = 0
  while line <= line('$')
    " number to float for division
    let length = strlen(getline(line)) + 0.0
    let width = length / a:winwidth
    let line_count += float2nr(ceil(width))
    if line_count == a:max
      continue
    endif
    let line += 1
  endwhile
  return max([min([line_count, a:max]), a:min])
endfunction

function! quickfix_height#_check_config() abort
  let min = get(g:, 'quickfix_min_height', 0)
  let max = get(g:, 'quickfix_max_height', 0)
  if min >= 0 && min <= max
    return [min, max]
  endif
  throw 'set a positive value to g:quickfix_min_height equal to or less than g:quickfix_max_height'
endfunction
