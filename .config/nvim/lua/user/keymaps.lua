local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  operator_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  operator_mode = "o",
}

---@alias map-mode string The keymap mode, can be one of the keys of mode_adapters
---@alias map-lhs string Left-hand side  of the mapping, `:h {lhs}`
---@alias map-rhs string|function Right-hand side of the mapping, `:h {rhs}`
---@alias desc string|function Used to give a description to the mapping
---@alias map-arguments string|table can be a single description string or a table, `:h :map-arguments`

---Set key mappings with overridable defaults `{ noremap = true, silent = true }`
-- ```lua
-- set_keymaps("n", "<leader>xy", function() print 'hello' end, "this is a description" )
-- set_keymaps("n", "<leader>xz", function() print 'hello' end, { noremap=true, buffer=true, desc = "this is also a description" } )
-- ```
---@overload fun(mode: map-mode, lhs: map-lhs, rhs: map-rhs, desc: desc|nil)
---@overload fun(mode: map-mode, lhs: map-lhs, rhs: map-rhs, opts: map-arguments|nil)
function M.set(mode, lhs, rhs, val)
  val = val or {}
  if type(val) ~= "table" then
    val = { desc = val }
  end
  val = vim.tbl_deep_extend("force", generic_opts[mode] or generic_opts_any, val)
  vim.keymap.set(mode, lhs, rhs, val)
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    local opts = {}
    if type(v) == "table" then
      opts = v[2] or {}
      v = v[1]
    end
    M.set(mode, k, v, opts)
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

    -- save file and quit insert-mode
    ["<C-s>"] = "<Esc><cmd>w<CR>",

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
    ["<S-l>"] = ":BufferLineCycleNext<CR>",
    ["<S-h>"] = ":BufferLineCyclePrev<CR>",

    ["<S-q>"] = "<cmd>BufferKill<cr>",

    -- Move current line / block with Alt-j/k a la vscode.
    -- FIXME: this interferes with tmux
    -- ["<A-j>"] = ":m .+1<CR>==",
    -- ["<A-k>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",
    ["Q"] = { "<cmd>BufferKill<cr>", "close buffer" },

    -- save file
    ["<C-s>"] = "<cmd>w<CR>",

    -- Page down/up
    ["[d"] = "<PageUp>",
    ["]d"] = "<PageDown>",

    -- fix gx
    ["gx"] = {
      function()
        require("user.utils").xdg_open_handler()
      end,
      { desc = "xdg open" },
    },

    ["<leader>fx"] = {
      function()
        print "hello"
      end,
      { desc = "print hello" },
    },

    -- quick rename
    ["<F2>"] = ":%s@<c-r><c-w>@<c-r><c-w>@gc<c-f>$F@i",
  },

  ---@usage change or add keymappings for terminal mode
  term_mode = {
    -- Terminal window navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },

  ---@usage change or add keymappings for visual mode
  visual_mode = {
    -- Allow pasting same thing many times
    ["P"] = '"_dP',

    -- better indent
    [">"] = "<gv",
    ["<"] = ">gv",

    -- move selected line(s)
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",

    -- only move one line at a time
    ["<S-Down>"] = "j",
    ["<S-Up"] = "k",

    -- search for visually selected text
    ["//"] = [[y/\V<C-R>=escape(@",'/\')<CR><CR>]],

    -- SnipRun
    ["<leader>f"] = "<esc><cmd>'<,'>SnipRun<CR>",
  },

  ---@usage change or add keymappings for visual block mode
  visual_block_mode = {
    -- Move selected line / block of text in visual mode
    ["K"] = ":move '<-2<CR>gv-gv",
    ["J"] = ":move '>+1<CR>gv-gv",

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",

    -- Sort lines
    ["<A-s>"] = "<esc>:'<,'>!sort -u<CR>",
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
