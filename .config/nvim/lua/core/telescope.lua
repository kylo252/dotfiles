local actions = require "telescope.actions"
local themes = require "telescope.themes"
local trouble = require "trouble.providers.telescope"

local inline_list = themes.get_ivy {
  previewer = false,
  sorting_strategy = "ascending",
  layout_strategy = "bottom_pane",
  layout_config = {
    height = 5,
    width = 0.5,
  },
  prompt = ">> ",
}

local center_list = themes.get_dropdown {
  layout_config = {
    winblend = 10,
    width = 0.5,
  },
  previewer = true,
}

require("telescope").setup {
  defaults = {
    layout_config = {
      center = {
        preview_cutoff = 70,
      },
      cursor = {
        preview_cutoff = 70,
      },
      height = 0.9,
      horizontal = {
        preview_cutoff = 120,
        prompt_position = "bottom",
      },
      vertical = {
        preview_cutoff = 70,
      },
      width = 0.8,
    },
    vimgrep_arguments = { "rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
    find_command = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--hidden",
      "--line-number",
      "--column",
      "--smart-case",
    },
    -- border = {},
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<S-Up>"] = actions.preview_scrolling_up,
        ["<S-Down>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-s>"] = trouble.open_with_trouble,
        -- ["<C-i>"] = my_cool_custom_action,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<S-Up>"] = actions.preview_scrolling_up,
        ["<S-Down>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-s>"] = trouble.open_with_trouble,
        -- ["<C-i>"] = my_cool_custom_action,
      },
    },
  },
  extensions = {
    fzf = { override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
    frecency = {
      show_scores = false,
      show_unindexed = true,
      show_fiter_column = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
      workspaces = {
        ["nvim"] = os.getenv "HOME" .. "/.config/nvim",
        ["zsh"] = os.getenv "HOME" .. "/.config/zsh",
        ["config"] = os.getenv "HOME" .. "/.config",
        ["data"] = os.getenv "HOME" .. "/.local/share",
      },
    },
  },
}

require("telescope").load_extension "fzf"
-- require("telescope").load_extension("session-lens")

local M = {}

function M.grep_neovim_dotfiles()
  require("telescope.builtin").live_grep { search_dirs = "~/.config/nvim", hidden = true }
end

function M.open_recent()
  require("telescope").extensions.frecency.frecency()
end

function M.find_dotfiles()
  local opts = vim.tbl_extend("keep", inline_list, {
    prompt_title = "~ dotfiles ~",
    cwd = "~",
    find_command = { "git", "dots", "ls-files" },
  })
  -- opts.layout_strategy = "flex"
  require("telescope.builtin").find_files(opts)
end

function M.find_lunarvim_files()
  local opts = vim.tbl_extend("keep", inline_list, {
    prompt_title = "~ LunarVim ~",
    cwd = "~/.local/share/lunarvim/lvim",
    find_command = { "git", "ls-files" },
  })
  -- opts.layout_strategy = "flex"
  require("telescope.builtin").find_files(opts)
end

function M.find_project_files()
  local opts = vim.tbl_extend("keep", center_list)
  local ok = pcall(require("telescope.builtin").git_files, opts)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

function M.grep_project_files()
  local opts = vim.tbl_extend("keep", center_list)
  require("telescope.builtin").grep_string(opts)
end

function M.scope_browser()
  require("telescope.builtin").file_browser {
    layout_config = {
      preview_width = 0.7,
      -- width = 0.15,
      prompt_position = "top",
    },
    layout_strategy = "horizontal",
    preview_title = false,
    hidden = false,
    sorting_strategy = "ascending",
    prompt_title = " File Browser",
    results_title = false,
    shorten_path = smart,
    show_line = false,
    winblend = 10,
  }
end

return M
