local M = {}

function M.config()
  local _, actions = pcall(require, "telescope.actions")
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

  local keymaps = {
    normal_mode = {
      ["<M-f>"] = "<cmd>Telescope live_grep<CR>",
      ["<C-p>"] = '<cmd>lua require("telescope.builtin").find_files({hidden = true, ignored = false})<CR>',
      ["<M-d>"] = '<cmd>lua require("core.telescope").get_z_list()<CR>',
    },
  }
  require("user.keymappings").load(keymaps)

  vim.cmd [[cmap <M-r> <Plug>(TelescopeFuzzyCommandSearch)]]

  M.setup_z()
  pcall(function()
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "projects"
  end)
end

return M
