" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.cache/fzf/history'
let g:fzf_buffers_jump = 1
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']


" Border color

" See `man fzf-tmux` for available options
if exists('$TMUX')
  " let g:fzf_layout = { 'tmux': '-p90%,60%' }
  let g:fzf_layout = { 'tmux': '-d20%' }
else
  " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
  let g:fzf_layout = { 'up': '20%' }
  " let g:fzf_layout = { 'left': '30%' }
endif

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* RgTest
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)
"
" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --ignore-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RgAdvanced call RipgrepFzf(<q-args>, <bang>0)

command! Dots call fzf#run(fzf#wrap({
  \ 'source': 'dotbare ls-files --full-name --directory "${DOTBARE_TREE}" | awk -v home="${DOTBARE_TREE}/" "{print home \$0}"',
  \ 'sink': 'e',
  \ 'options': [ '--multi', '--preview', 'bat --style=numbers --color=always --pager=never --highlight-line=0 {}' ]
  \ }))

nnoremap <C-p> :Files<CR>
nnoremap <C-f> :BLines<CR>
nnoremap <leader>df :Dots<CR>
nnoremap <leader>b :Buffers<CR>
