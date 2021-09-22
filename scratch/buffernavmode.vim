if exists('g:loaded_buffernavmode')
	finish
endif
let g:loaded_buffernavmode = 1

let g:bufferNavModes = {
\	'j': 'wincmd k',
\	'k': 'wincmd j',
\	'h': 'wincmd h',
\	'l': 'wincmd l',
\}

function! s:bufferNavFunc() abort
	let l:userInput = nr2char(g:buffer_movesModeInput)

	if l:userInput == 'j'
		execute 'wincmd k'
	elseif l:userInput == 'k'
		execute 'wincmd j'
	elseif l:userInput == 'h'
		execute 'wincmd h'
	elseif l:userInput == 'l'
		execute 'wincmd l'
    else
		execute '<Esc>'
	endif
endfunction

" This isnt required. the timeout is only for ambiguous table entries like j
" and jl...
function! s:BufferNavCmd() abort
  let l:timeoutlen = &timeoutlen
  let &timeoutlen = 1500
  "call libmodal#Enter('BUFFER_MOVES', g:bufferNavModes)
  call libmodal#Enter('BUFFER_MOVES', funcref('s:bufferNavFunc'))
  "call luaeval("require('libmodal').mode.enter('BUFFER_MOVES'.._A, 's:bufferNavFunc')", "")
  let &timeoutlen = l:timeoutlen
endfunction

if 0==1
nnoremap <silent> <unique> <Plug>(BufferNavMode) <Cmd>call <SID>BufferNavCmd()<CR>
for mode in ['n', 'i', 't']
  let s:subm_keyprefix = '<C-w>'
  let s:subm_keypostfix = '<Plug>(BufferNavMode)'
  if mode ==# 't'
    let s:subm_keyprefix = '<Esc><C-\><C-N><C-W>'
    execute 'tnoremap <silent> <unique> <leader>h '.s:subm_keyprefix.'h'.s:subm_keypostfix
    execute 'tnoremap <silent> <unique> <leader>l '.s:subm_keyprefix.'l'.s:subm_keypostfix
    execute 'tnoremap <silent> <unique> <leader>j '.s:subm_keyprefix.'k'.s:subm_keypostfix
    execute 'tnoremap <silent> <unique> <leader>k '.s:subm_keyprefix.'j'.s:subm_keypostfix
  endif
  if mode ==# 'i'
    execute 'inoremap <silent> <unique> <leader>h '.s:subm_keyprefix.'h'.s:subm_keypostfix
    execute 'inoremap <silent> <unique> <leader>l '.s:subm_keyprefix.'l'.s:subm_keypostfix
    execute 'inoremap <silent> <unique> <leader>j '.s:subm_keyprefix.'k'.s:subm_keypostfix
    execute 'inoremap <silent> <unique> <leader>k '.s:subm_keyprefix.'j'.s:subm_keypostfix
  endif
  if mode ==# 'n'
    echo 'running noremap <silent> <unique> <leader>h '.s:subm_keyprefix.'h'.s:subm_keypostfix
    execute 'nmap <silent> <unique> <leader>h '.s:subm_keyprefix.'h'.s:subm_keypostfix
    execute 'nmap <silent> <unique> <leader>l '.s:subm_keyprefix.'l'.s:subm_keypostfix
    execute 'nmap <silent> <unique> <leader>j '.s:subm_keyprefix.'k'.s:subm_keypostfix
    execute 'nmap <silent> <unique> <leader>k '.s:subm_keyprefix.'j'.s:subm_keypostfix
  endif
endfor
endif

  nmap <silent> <unique> <leader>h <C-W>h<Plug>(BufferNavMode)'
  nmap <silent> <unique> <leader>j <C-W>k<Plug>(BufferNavMode)'
  nmap <silent> <unique> <leader>k <C-W>j<Plug>(BufferNavMode)'
  nmap <silent> <unique> <leader>l <C-W>l<Plug>(BufferNavMode)'
" Lua callback doesnt work yet"
if !exists(':BufferNavMode')
  echo "Running buffer nav?"
	command! BufferNavMode lua require('buffernavmode')()
endif
"


