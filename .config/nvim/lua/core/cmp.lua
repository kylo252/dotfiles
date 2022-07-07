local M = {}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local feedkeys = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp_format_layout = function(entry, vim_item)
  local icons = require("user.lsp").get_lsp_kind()
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
    formatting = { format = cmp_format_layout },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
    },
    sources = {
      { name = "nvim_lsp", keyword_length = 2 },
      { name = "nvim_lua", keyword_length = 2 },
      { name = "luasnip", keyword_length = 2 },
      { name = "buffer", keyword_length = 4 },
      {
        name = "tmux",
        keyword_length = 4,
        options = {
          all_panes = false,
          label = "[tmux]",
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
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          feedkeys("<Plug>luasnip-expand-or-jump", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          feedkeys("<Plug>luasnip-jump-prev", "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<C-p>"] = { i = cmp.mapping.select_prev_item(), c = cmp.mapping.select_prev_item() },
      ["<C-n>"] = { i = cmp.mapping.select_next_item(), c = cmp.mapping.select_next_item() },
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-c>"] = function()
        cmp.mapping.close()
        vim.cmd [[stopinsert]]
      end,
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
  }

  -- Use buffer source for `/`
  cmp.setup.cmdline("/", {
    sources = {
      -- TODO: test out `rg` completion source
      { name = "buffer" },
    },
  })
end
return M
