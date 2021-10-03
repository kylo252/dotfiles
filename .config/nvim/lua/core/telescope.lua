local M = {}


function M.config()
local custom_actions = require "core.telescope.custom-actions"
  local _, actions = pcall(require, "telescope.actions")

  return {
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
      vimgrep_arguments = {
        "rg",
        "--no-heading",
        "--hidden",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      find_command = { "fd", "--type=file", "--hidden" },
      file_sorter = require("telescope.sorters").fuzzy_with_index_bias,
      mappings = {
        i = {
          ["<C-c>"] = actions.close,
          ["<S-Up>"] = actions.preview_scrolling_up,
          ["<S-Down>"] = actions.preview_scrolling_down,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-space>"] = custom_actions.fuzzy_filter_results,

          -- ["<C-i>"] = my_cool_custom_action,
        },
        n = {
          ["<C-c>"] = actions.close,
          ["<S-Up>"] = actions.preview_scrolling_up,
          ["<S-Down>"] = actions.preview_scrolling_down,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-space>"] = custom_actions.fuzzy_filter_results,
          -- ["<C-i>"] = my_cool_custom_action,
        },
      },
    },
    extensions = {
      fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
    },
  }
end

function M.setup_z()
  local _, builtin = pcall(require, "telescope.builtin")
  local _, themes = pcall(require, "telescope.themes")

  require("telescope._extensions.zoxide.config").setup {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 15,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ Zoxide ~",
    mappings = {
      ["<C-f>"] = {
        action = function(selection)
          builtin.find_files(themes.get_ivy { cwd = selection.path })
          vim.cmd [[normal! A]]
        end,
      },
      ["<C-g>"] = {
        action = function(selection)
          builtin.live_grep(themes.get_ivy { cwd = selection.path })
          vim.cmd [[normal! A]]
        end,
      },
    },
  }
end

function M.setup()
  local opts = M.config()
  require("telescope").setup(opts)

  vim.cmd [[ command! -nargs=* FuzzyGrepString :lua require('core.telescope.custom-actions').fuzzy_grep_string(<f-args>) ]]

  local keymaps = {
    normal_mode = {
      ["<M-f>"] = "<cmd>Telescope live_grep<CR>",
      ["<C-p>"] = '<cmd>lua require("telescope.builtin").find_files({hidden = true, ignored = false})<CR>',
      ["<M-d>"] = '<cmd>lua require("core.telescope").get_z_list()<CR>',
    },
  }
  vim.cmd [[cmap <M-r> <Plug>(TelescopeFuzzyCommandSearch)]]
  require("keymappings").load(keymaps)
end

return M
