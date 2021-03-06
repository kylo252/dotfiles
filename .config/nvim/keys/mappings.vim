let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" vnoremap <leader>p "+p
" vnoremap <leader>P "+P
" nmap <localleader>p o<ESC>p

" Enabble paste mode 
inoremap <F2> <esc>:set paste!<cr>i
nnoremap <F2> :set paste!<cr>

" easy escape
inoremap jk <esc>
inoremap kj <esc>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Close current window
nnoremap <leader>qw :hide<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" easier splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" press F9 to fold 
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" start merge mode
nmap <leader>mt <plug>(MergetoolToggle) 

" Move selected line / block of text in visual mode
" shift + k to move up
" shift + j to move down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv
  
" Easy resize windows
nnoremap <silent> <C-S-Up>    :resize -2<CR>
nnoremap <silent> <C-S-Down>  :resize +2<CR>
nnoremap <silent> <C-S-Left>  :vertical resize -2<CR>
nnoremap <silent> <C-S-Right> :vertical resize +2<CR>

vnoremap > >gv
vnoremap < <gv
