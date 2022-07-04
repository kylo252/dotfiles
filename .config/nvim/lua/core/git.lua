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

local function get_gerrit_gitlies_type_url(url_data)
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

function M.setup_gitlinker()
  local gitlinker = require "gitlinker"

  gitlinker.setup {
    callbacks = {
      ["gerrit"] = get_gerrit_gitlies_type_url,
    },
    mappings = nil,
  }

  local keymaps = {
    normal_mode = {
      ["<leader>gy"] = {
        function()
          require_safe("gitlinker").get_buf_range_url "n"
        end,
        "Copy line URL",
      },
      ["<leader>gYy"] = {
        function()
          require_safe("gitlinker").get_buf_range_url("n", { remote = "origin" })
        end,
        "Copy line URL (origin)",
      },
      ["<leader>gYr"] = {
        function()
          require("gitlinker").get_repo_url { remote = "origin" }
        end,
        "Copy repo URL",
      },
      ["<leader>gYb"] = {
        function()
          M.get_github_blame_url { remote = "origin" }
        end,
        "Copy blame URL",
      },
    },
    visual_mode = {
      ["<leader>gy"] = {
        function()
          require_safe("gitlinker").get_buf_range_url "v"
        end,
        "Copy range URL",
      },
      ["<leader>gY"] = {
        function()
          require_safe("gitlinker").get_buf_range_url("v", { remote = "origin" })
        end,
        "Copy range URL (origin)",
      },
    },
  }

  require("user.keymaps").load(keymaps)
end

function M.get_github_blame_url(opts)
  local gitlinker = require "gitlinker"
  local user_opts = vim.tbl_deep_extend("force", {
    print_url = false,
    remote = "origin",
  }, opts or {})
  local repo_url = gitlinker.get_repo_url(user_opts)

  local win_id = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()
  local cur_pos = vim.api.nvim_win_get_cursor(win_id)
  ---@diagnostic disable-next-line: missing-parameter
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local repo = vim.loop.cwd()
  local lnum = cur_pos[1]
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
