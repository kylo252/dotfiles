local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  operator_mode = generic_opts,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  operator_mode = "o"
}

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

M.groups = {
  ---@usage change or add keymappings for insert mode
  insert_mode = {
    -- 'jk' for quitting insert mode
    ["jk"] = "<ESC>",
    -- 'kj' for quitting insert mode
    ["kj"] = "<ESC>",
    -- 'jj' for quitting insert mode
    ["jj"] = "<ESC>",
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",

    -- save file
    ["<C-s>"] = "<cmd>w<CR>",
    ["<C-c>"] = "<ESC>",

    -- move the cursor
    ["<A-h>"] = "<Left>",
    ["<A-l>"] = "<Right>",
  },

  ---@usage change or add keymappings for normal mode
  normal_mode = {
    -- Better window movement
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    ["<M-f>"] = "<cmd>Telescope live_grep<CR>",

    -- Tab switch buffer
    ["<S-l>"] = ":BufferNext<CR>",
    ["<S-h>"] = ":BufferPrevious<CR>",

    -- Move current line / block with Alt-j/k a la vscode.
    -- FIXME: this interferes with tmux
    -- ["<A-j>"] = ":m .+1<CR>==",
    -- ["<A-k>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",

    -- save file
    ["<C-s>"] = ":w<CR>",

    -- Page down/up
    ["[d"] = "<PageUp>",
    ["]d"] = "<PageDown>",

    -- fix gx
    ["gx"] = "<cmd>lua require('utils').xdg_open_handler()<cr>",

    -- quick rename
    ["<F2>"] = ":%s@<c-r><c-w>@<c-r><c-w>@gc<c-f>$F@i",
  },

  ---@usage change or add keymappings for terminal mode
  term_mode = {
    -- Terminal window navigation
    -- ["<C-c>"] = "<Esc>",
    ["<Esc>"] = [[<C-\><C-n>]],
  },

  ---@usage change or add keymappings for visual mode
  visual_mode = {
    -- Allow pasting same thing many times
    ["p"] = '""p:let @"=@0<CR>',

    -- better indent
    [">"] = "<gv",
    ["<"] = ">gv",

    -- Visual mode pressing * or # searches for the current selection
    ["*"] = "<cmd>/\\<<C-r>=expand('<cword>')<CR>\\><CR>",
    ["#"] = "<cmd>?\\<<C-r>=expand('<cword>')<CR>\\><CR>",

    -- move selected line(s)
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",

    -- only move one line at a time
    ["<S-Down>"] = "j",
    ["<S-Up"] = "k",

    -- fix gx
    ["gx"] = "<cmd>lua require('utils').xdg_open_handler()<cr>",
  },

  ---@usage change or add keymappings for visual block mode
  visual_block_mode = {
    -- Move selected line / block of text in visual mode
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",
  },

  operator_mode = {},
}

-- Add some text objects
local chars = { "_", ".", ":", ",", ";", "<bar>", "/", "<bslash>", "*", "+", "%", "-", "#" }
for _, char in ipairs(chars) do
  M.groups.visual_mode["i" .. char] = ":<C-u>normal! T" .. char .. "vt" .. char .. "<CR>"
  M.groups.operator_mode["i" .. char] = ":normal vi" .. char .. "<CR>"

  M.groups.visual_mode["a" .. char] = ":<C-u>normal! F" .. char .. "vf" .. char .. "<CR>"
  M.groups.operator_mode["a" .. char] = ":normal va" .. char .. "<CR>"
end
M.groups.visual_mode["ae"] = ":<C-u>keepjumps normal! ggVG<CR>"
M.groups.operator_mode["ae"] = ":normal vae<CR>"

function M.setup()
  vim.g.mapleader = " "
  -- Search and replace word under cursor using <F2>
  -- vim.cmd [[ nnoremap <F2> :%s@<c-r><c-w>@<c-r><c-w>@gc<c-f>$F@i ]]
  M.load(M.groups)
end

return M
