local M = {}

function M.config()
  local _, actions = pcall(require, "telescope.actions")
  local _, builtin = pcall(require, "telescope.builtin")
  local _, themes = pcall(require, "telescope.themes")

  return {
    defaults = themes.get_ivy {
      layout_config = {
        center = {
          preview_cutoff = 70,
        },
        cursor = {
          preview_cutoff = 70,
        },
        horizontal = {
          preview_cutoff = 120,
          prompt_position = "bottom",
        },
        vertical = {
          preview_cutoff = 70,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--hidden",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--glob=!.git/",
      },
      winblend = 0,
      find_command = { "fd", "--type=file", "--hidden" },
      mappings = {
        i = {
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<S-Up>"] = actions.cycle_previewers_prev,
          ["<S-Down>"] = actions.cycle_previewers_next,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-h>"] = actions.which_key, -- keys from pressing <C-/>
          -- ["<C-i>"] = my_cool_custom_action,
        },
        n = {
          ["<C-c>"] = actions.close,
          ["<S-Up>"] = actions.cycle_previewers_prev,
          ["<S-Down>"] = actions.cycle_previewers_next,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          -- ["<C-Space>"] = custom_actions.fuzzy_filter_results,
          -- ["<C-i>"] = my_cool_custom_action,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      live_grep = {
        only_sort_text = true,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      zoxide = {
        prompt = ">> ",
        prompt_title = "~ Zoxide ~",
        mappings = {
          default = {
            action = function(selection)
              vim.api.nvim_set_current_dir(selection.path)
              vim.cmd("lcd " .. selection.path)
            end,
            after_action = function(selection)
              dump(selection)
              print("Directory changed to " .. selection.path)
            end,
          },
          ["<C-f>"] = {
            action = function(selection)
              builtin.find_files { cwd = selection.path }
            end,
          },
          ["<C-g>"] = {
            action = function(selection)
              builtin.live_grep { cwd = selection.path }
            end,
          },
        },
      },
    },
  }
end

function M.setup()
  local opts = M.config()

  require("telescope").setup(opts)
  local finders = require "core.telescope.custom-finders"
  local keymaps = {
    normal_mode = {
      ["<C-p>"] = { "<cmd>Telescope find_files<CR>", "find project files" },
      ["<leader>ft"] = {
        function()
          finders.dynamic_grep { args = "ft=" .. vim.bo.filetype }
        end,
        "live grep (same filetype)",
      },
    },
  }
  require("user.keymaps").load(keymaps)

  pcall(function()
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "projects"
    require("telescope").load_extension "zoxide"
  end)
end

return M
