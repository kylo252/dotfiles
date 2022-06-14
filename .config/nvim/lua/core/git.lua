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
    sign_priority = 10000,
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

function M.get_blame_url()
  local repo_url = require("gitlinker").get_repo_url { print_url = false }

  local win_id = vim.api.nvim_get_current_win()
  local cur_pos = vim.api.nvim_win_get_cursor(win_id)
  local filename = vim.fn.expand "%"
  local repo = require("lspconfig.util").find_git_ancestor(vim.fn.expand "%:p")
  local lnum = cur_pos[1] + 1
  local args = {
    "log",
    "-L" .. lnum .. "," .. lnum + 1 .. ":" .. filename,
    "--pretty=%H",
    "--no-patch",
  }
  local job = require("plenary.job"):new { command = "git", args = args, cwd = repo }
  local commit_url
  job:after_success(function(this_job)
    local commit_sha = this_job:result()[1]
    commit_url = repo_url .. "/commit/" .. commit_sha
    vim.schedule(function()
      vim.notify(commit_url, vim.log.levels.INFO, { title = "commit url" })
      vim.fn.setreg("+", commit_url)
    end)
  end)
  job:start()
end

return M
