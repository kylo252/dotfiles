let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:startify_bookmarks = [ 
       \ {'i': '~/.config/nvim/init.vim'},
       \ {'p': '~/.config/nvim/general/plug.vim'},
       \ {'z': '~/.zshrc.user'} 
       \]


" Enable the option only in case you think Vim starts too slowly (because of
" :Startify) or if you often edit files on remote filesystems
let g:startify_enable_unsafe = 1

" Show environment variables in path, if their name is shorter than their value.
let g:startify_use_env = 0

" Open buffer
nnoremap <leader>st :Startify<CR>
