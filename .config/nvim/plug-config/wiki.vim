" VimWiki
  let g:vimwiki_key_mappings =
    \ {
    \   'all_maps': 1,
    \   'global': 1,
    \   'headers': 1,
    \   'text_objs': 1,
    \   'table_format': 1,
    \   'table_mappings': 1,
    \   'lists': 1,
    \   'links': 1,
    \   'html': 1,
    \   'mouse': 1,
    \ }


" Filetypes enabled for
let g:vimwiki_filetypes = ['markdown']

let g:vimwiki_list = [{'path': '/tmp/notes',
                      \ 'syntax': 'markdown', 'ext': '.md', 'exclude_files': ['**/README.md', '**/Readme.md'] }]

let g:vimwiki_tab_key = '<F7>'
let g:vimwiki_shift_tab_key = '<F8>'

nmap <Leader><Tab> <Plug>VimwikiNextLink
nmap <Leader><S-Tab> <Plug>VimwikiPrevLink

let g:vim_markdown_folding_disabled = 1

let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "
