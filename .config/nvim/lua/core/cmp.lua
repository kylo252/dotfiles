local M = {}
local function check_backspace()
  local col = vim.fn.col "." - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
    return true
  else
    return false
  end
end

M.config = function()
  -- nvim-cmp setup
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  cmp.setup {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
mapping = {
  ['<Tab>'] = function(fallback)
    if vim.fn.pumvisible() == 1 then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
    elseif check_back_space() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
    elseif vim.fn['vsnip#available']() == 1 then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
    else
      fallback()
    end
  end,
},
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      {
        name = "buffer",
        opts = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end,
        },
      },
    },
  }
end
return M
