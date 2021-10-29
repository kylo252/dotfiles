local M = {}

function M.setup_gitsigns()
  require("gitsigns").setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "│" },
      change = { hl = "GitSignsChange", text = "│" },
      delete = { hl = "GitSignsDelete", text = "_" },
      topdelete = { hl = "GitSignsDelete", text = "‾" },
      changedelete = { hl = "GitSignsChange", text = "~" },
    },
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,

      ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
      ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    },
  }
end

function M.setup_gitlinker()

  local gitlinker = require "gitlinker"
  local hosts = require("gitlinker").hosts

  local get_gerrit_gitlies_type_url = function(url_data)
    local url = "https://" .. url_data.host .. "/plugins/gitiles/" .. url_data.repo
    if not url_data.file or not url_data.rev then
      return url
    end
    url = url .. "/+/" .. url_data.rev .. "/" .. url_data.file
    if not url_data.lstart then
      return url
    end
    url = url .. "#" .. url_data.lstart
    return url
  end

  gitlinker.setup {
    callbacks = {
      ["github.com"] = hosts.get_github_type_url,
      ["gerrit"] = get_gerrit_gitlies_type_url,
    },
  }
end

return M
