local M = {}

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local T = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp_format_layout = function(entry, vim_item)
  local icons = require("lsp").get_lsp_kind()
  vim_item.kind = icons[vim_item.kind]
  vim_item.menu = ({
    nvim_lsp = "(LSP)",
    nvim_lua = "(API)",
    path = "(Path)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
  })[entry.source.name]
  return vim_item
end

M.config = function()
  local status_cmp_ok, cmp = pcall(require, "cmp")
  if not status_cmp_ok then
    return
  end
  local status_luasnip_ok, luasnip = pcall(require, "luasnip")
  if not status_luasnip_ok then
    return
  end
  cmp.setup {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    formatting = { format = cmp_format_layout },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    sources = {
      { name = "nvim_lua", keyword_length = 2 },
      { name = "nvim_lsp", keyword_length = 2 },
      { name = "luasnip", keyword_length = 2 },
      { name = "buffer", keyword_length = 5 },
      {
        name = "tmux",
        keyword_length = 4,
        opts = {
          all_panes = false,
          label = "[tmux]",
          trigger_characters = { "." },
        },
      },
      { name = "path", keyword_length = 4 },
    },
    experimental = {
      -- I like the new menu better! Nice work hrsh7th
      native_menu = false,

      -- Let's play with this for a day or two
      ghost_text = true,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(function()
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(T "<C-n>", "n")
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(T "<Plug>luasnip-expand-or-jump", "")
        elseif check_backspace() then
          vim.fn.feedkeys(T "<Tab>", "n")
        else
          vim.fn.feedkeys(T "<Tab>", "n")
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(T "<C-p>", "n")
        elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(T "<Plug>luasnip-jump-prev", "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),

      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-c>"] = function()
        cmp.mapping.close()
        vim.cmd [[stopinsert]]
      end,
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
  }
end
return M
