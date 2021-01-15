" NOTE: This variable doesn't exist before barbar runs. Create it before
"       setting any option.
" let bufferline = {}
let bufferline = get(g:, 'bufferline', {})

" Enable/disable animations
let bufferline.animation = v:true

" Show a shadow over the editor in buffer-pick mode
let bufferline.shadow = v:true

" Enable/disable icons
let bufferline.icons = v:true

" Enables/disable clickable tabs
"  - left-click: go to buffer
"  - middle-click: delete buffer
let bufferline.clickable = v:true

" If set, the letters for each buffer in buffer-pick mode will be
" assigned based on their name. Otherwise or in case all letters are
" already assigned, the behavior is to assign letters in order of
" usability (see order below)
let bufferline.semantic_letters = v:true

" New buffer letters are assigned in this order. This order is
" optimal for the qwerty keyboard layout but might need adjustement
" for other layouts.
let bufferline.letters = 
  \ 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP'

" Sets the maximum padding width with which to surround each tab
let bufferline.maximum_padding = 4

" better buffer management
nnoremap <Leader>q :BufferClose<CR>
nnoremap <Leader>qq :BufferWipeout<CR>

" Magic buffer-picking mode
nnoremap <Leader>j :BufferPick<CR>

" Sort automatically by...
nnoremap <Leader>bd :BufferOrderByDirectory<CR>
nnoremap <Leader>bl :BufferOrderByLanguage<CR>

" Move to previous/next
nnoremap <TAB> :BufferNext<CR>
nnoremap <S-TAB> :BufferPrevious<CR>
