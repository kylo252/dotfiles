local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
}

-- Append key mappings to lunarvim's defaults for a given mode
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.append_to_defaults(keymaps)
  for mode, mappings in pairs(keymaps) do
    for k, v in ipairs(mappings) do
      lvim.keys[mode][k] = v
    end
  end
end

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
    -- navigation
    ["<A-Up>"] = "<C-\\><C-N><C-w>k",
    ["<A-Down>"] = "<C-\\><C-N><C-w>j",
    ["<A-Left>"] = "<C-\\><C-N><C-w>h",
    ["<A-Right>"] = "<C-\\><C-N><C-w>l",
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },

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

    -- Resize with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Tab switch buffer
    ["<S-l>"] = ":BufferNext<CR>",
    ["<S-h>"] = ":BufferPrevious<CR>",

    -- Move current line / block with Alt-j/k a la vscode.
    ["<A-j>"] = ":m .+1<CR>==",
    ["<A-k>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",

    -- save file
    ["<C-s>"] = ":w<CR>",

    -- Page down/up
    ["[d"] = "<PageUp>",
    ["]d"] = "<PageDown>",
  },

  ---@usage change or add keymappings for terminal mode
  term_mode = {
    -- Terminal window navigation
    ["<Esc>"] = [[<C-\><C-n>]],
    -- ["<C-c>"] = "<Esc>",
  },

  ---@usage change or add keymappings for visual mode
  visual_mode = {
    -- Allow pasting same thing many times
    ["p"] = '""p:let @"=@0<CR>',

    -- better indent
    [">"] = "<gv",
    ["<"] = ">gv",

    -- Visual mode pressing * or # searches for the current selection
    -- { "*", "<cmd>/\\<<C-r>=expand('<cword>')<CR>\\><CR>" },
    ["#"] = "<cmd>?\\<<C-r>=expand('<cword>')<CR>\\><CR>",

    -- move selected line(s)
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",
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
}

function M.setup()
  vim.g.mapleader = " "
  -- Search and replace word under cursor using <F2>
  vim.cmd [[ nnoremap <F2> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i ]]
  M.load(M.groups)
end

return M
