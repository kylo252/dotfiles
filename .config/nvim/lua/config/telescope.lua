local wk = require("which-key")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local themes = require("telescope.themes")

local opts = {silent=true, noremap=true}
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", "<cmd>Telescope live_grep<CR>", opts)

local keymap = {
    f = {
		name = "+Find",
		b = {"<cmd>Telescope buffers<CR>", "buffers"},
        c = {"<cmd>Telescope colorscheme<CR>", "Colorscheme"},
        f = {"<cmd>Telescope find_files<CR>", "Find Files"},
        p = {"<cmd>Telescope git_files<CR>", "Find Project Files"},
        g = {"<cmd>Telescope live_grep<CR>", "Live Grep"},
		h = {"<cmd>Telescope help_tags<CR>", "help tags"},
        m = {"<cmd>Telescope marks<CR>", "Marks"},
        M = {"<cmd>Telescope man_pages<CR>", "Man Pages"},
        r = {"<cmd>Telescope oldfiles<CR>", "Open Recent File"},
        R = {"<cmd>Telescope registers<CR>", "Registers"},
    },
	c = {
        name = "+commands",
        c = {"<cmd>Telescope commands<CR>", "commands"},
        h = {"<cmd>Telescope command_history<CR>", "history"},
    },
    g = {
        name = "+git",
        g = {"<cmd>Telescope git_commits<CR>", "commits"},
        c = {"<cmd>Telescope git_bcommits<CR>", "bcommits"},
        b = {"<cmd>Telescope git_branches<CR>", "branches"},
        s = {"<cmd>Telescope git_status<CR>", "status"},
    },
    z = {
		p = {"<cmd>lua require\"config.telescope\".edit_project_files()<CR>", "Open project files"},
		n = {"<cmd>lua require\"config.telescope\".edit_neovim_dotfiles()<CR>", "Open neovim config"},
		z = {"<cmd>lua require\"config.telescope\".edit_zsh_dotfiles()<CR>", "Open ZSH config"},
    },
}

wk.register(keymap, { prefix = "<leader>" })

require("telescope").setup {
    defaults = {
        vimgrep_arguments = {"rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"},
        find_command = {"rg", "--no-heading", "--with-filename", "--hidden", "--line-number", "--column", "--smart-case"},
        -- file_sorter = sorters.get_fuzzy_file,
        file_ignore_patterns = {},
        -- generic_sorter = sorters.get_generic_fuzzy_sorter,
        -- shorten_path = true,
        -- border = {},
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,

        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["Q"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-q>"] = actions.close,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- ["<C-i>"] = my_cool_custom_action,
            }
        },
	},
	extensions = {
		fzf = {
		  override_generic_sorter = false,
		  override_file_sorter = false,
	      case_mode = "smart_case"
		},
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
	},
}

-- require("telescope").load_extension("fzf") -- superfast sorter

local quickSnipes = {}
--[[
	call via:
	:lua require"telescope-config".edit_neovim()

	example keymap:
	vim.api.nvim_set_keymap("n", "<Leader>nn", "<CMD>lua require\"telescope-config\".edit_neovim()<CR>", {noremap = true, silent = true})
--]]
function quickSnipes.edit_neovim_dotfiles()
  require("telescope.builtin").find_files {
    prompt_title = "~ dotfiles (neovim) ~",
    find_command = {"fd", "-uu"},
    cwd = "~/.config/nvim",
	shorten_path = false,
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        preview_width = 120,
      },
      vertical = {
        preview_height = 0.75,
      },
    },
  }
end

function quickSnipes.edit_zsh_dotfiles()
  require("telescope.builtin").find_files {
    prompt_title = "~ dotfiles (zsh) ~",
    cwd = "~/.config/zsh",
	shorten_path = false,
    find_command = {"fd", "-uu", "-E", "*.zwc"},
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        preview_width = 120,
      },
      vertical = {
        preview_height = 0.75,
      },
    },
  }
end

function quickSnipes.edit_project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return quickSnipes


