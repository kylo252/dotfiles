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
    current_line_blame_formatter = " <abbrev_sha> <summary> (<author>, <author_time:%Y-%m-%d>)",
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        if type(opts) == "string" then
          opts = { desc = opts }
        end
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "next hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "prev hunk" })

      -- Actions
      map({ "n", "v" }, "<leader>gs", gs.stage_hunk, "stage hunk")
      map({ "n", "v" }, "<leader>gu", gs.undo_stage_hunk, "undo stage hunk")
      map({ "n", "v" }, "<leader>gr", gs.reset_hunk, "reset hunk")
      map("n", "<leader>gS", gs.stage_buffer, "stage buffer")
      map("n", "<leader>gR", gs.reset_buffer, "reset buffer")
      map("n", "<leader>gp", gs.preview_hunk, "preview hunk")
      map("n", "<leader>gb", function()
        gs.blame_line { full = true }
      end, "blame")
      map("n", "<leader>gt", gs.toggle_current_line_blame, "toggle current line blame")
      map("n", "<leader>ghd", gs.diffthis, "diff this")
      map("n", "<leader>ghD", function()
        gs.diffthis "~"
      end, "diff this with ~")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")
    end,
    yadm = {
      enable = false,
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
