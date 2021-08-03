local u = require "utils"

vim.g.mapleader = " "

-- normal {{{1
u.add_keymap("n", { noremap = true, silent = true }, {
  -- set leader key
  { "<Space>", "<NOP>" },

  -- Jump list
  { "[j", "<cmd>cprev<CR>" },
  { "]j", "<cmd>cnext<CR>" },

  -- save file
  { "<C-c>", "<Esc>" },
  { "<C-s>", ":w<CR>" },

  -- Page down/up
  { "[d", "<PageUp>" },
  { "]d", "<PageDown>" },
})

-- visual {{{1
u.add_keymap("x", { noremap = true, silent = true }, {
  -- Allow pasting same thing many times
  { "p", '""p:let @"=@0<CR>' },

  -- better indent
  { ">", "<gv" },
  { "<", ">gv" },

  -- Visual mode pressing * or # searches for the current selection
  -- { "*", "<cmd>/\\<<C-r>=expand('<cword>')<CR>\\><CR>" },
  { "#", "<cmd>?\\<<C-r>=expand('<cword>')<CR>\\><CR>" },

  -- move selected line(s)
  { "K", ":move '<-2<CR>gv-gv" },
  { "J", ":move '>+1<CR>gv-gv" },
})

-- insert {{{1
u.add_keymap("i", { noremap = true, silent = true }, {
  -- alternative esc
  { "<C-c>", "<Esc>" },
  { "jk", "<Esc>" },
  { "kj", "<Esc>" },

  -- save file
  { "<C-s>", "<cmd>w<CR>" },

  -- move the cursor
  { "<A-h>", "<Left>" },
  { "<A-j>", "<Down>" },
  { "<A-k>", "<Up>" },
  { "<A-l>", "<Right>" },
})

-- terminal {{{1
u.add_keymap("t", { noremap = true, silent = true }, {
  -- escape in terminal
  { "<Esc>", [[<C-\><C-n>]] },
  { "<C-c>", "<Esc>" },
})

-- Search and replace word under cursor using <F2>
vim.cmd [[ nnoremap <F2> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i ]]
