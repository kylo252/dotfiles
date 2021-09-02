local M = {
  custom_actions = {},
}

function M.config()
  local status_ok, actions = pcall(require, "telescope.actions")
  if not status_ok then
    return
  end

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
      -- file_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      mappings = {
        i = {
          ["<C-c>"] = actions.close,
          ["<S-Up>"] = actions.preview_scrolling_up,
          ["<S-Down>"] = actions.preview_scrolling_down,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-g>"] = M.custom_actions.fuzzy_filter_results,

          -- ["<C-i>"] = my_cool_custom_action,
        },
        n = {
          ["<C-c>"] = actions.close,
          ["<S-Up>"] = actions.preview_scrolling_up,
          ["<S-Down>"] = actions.preview_scrolling_down,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-g>"] = M.custom_actions.fuzzy_filter_results,
          -- ["<C-i>"] = my_cool_custom_action,
        },
      },
    },
    extensions = {
      fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
    },
  }
end

function M.setup()
  local opts = M.config()
  require("telescope").setup(opts)

  require("telescope").load_extension "fzf"

  vim.cmd [[ command! -nargs=* GS :lua require('core.telescope').fuzzy_grep_string(<f-args>) ]]

  local keymaps = {
    normal_mode = {
      ["<M-f>"] = "<cmd>Telescope live_grep<CR>",
      ["<C-p>"] = '<cmd>lua require("telescope.builtin").find_files({hidden = true, ignored = false})<CR>',
      ["<M-d>"] = '<cmd>lua require("core.telescope").get_z_list()<CR>',
    },
  }
  vim.cmd [[cmap <C-R> <Plug>(TelescopeFuzzyCommandSearch)]]
  require("keymappings").load(keymaps)
end

function M.grep_dotfiles()
  M.live_grep_v2 {
    search_dirs = { CONFIG_PATH, os.getenv "ZDOTDIR" },
    hidden = true,
  }
end

function M.find_dotfiles()
  local opts = require("telescope.themes").get_ivy {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 5,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ dotfiles ~",
    cwd = "~",
    find_command = { "git", "dots", "ls-files" },
  }
  require("telescope.builtin").find_files(opts)
end

function M.get_z_list()
  local opts = require("telescope.themes").get_ivy {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 5,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ Zoxide ~",
  }
  require("telescope").extensions.zoxide.list(opts)
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
    show_line = false,
    winblend = 10,
  }
end

function M.fuzzy_grep_string(query)
  query = query or {}
  local builtin = require "telescope.builtin"
  local themes = require "telescope.themes"
  builtin.grep_string(themes.get_ivy {
    prompt_title = "Fuzzy grep string, initial query: " .. query,
    search = query,
  })
end

function M.live_grep_v2(opts)
  opts = opts or {}
  require("telescope.builtin").live_grep(vim.tbl_deep_extend("force", {
    prompt_title = "Search",
    attach_mappings = function(_, map)
      map("i", "<C-g>", M.custom_actions.fuzzy_filter_results)
      map("n", "<C-g>", M.custom_actions.fuzzy_filter_results)
      return true
    end,
  }, opts))
end

local theme_opts = {
  theme = "dropdown",
  sorting_strategy = "ascending",
  layout_strategy = "center",
  layout_config = {
    preview_cutoff = 1, -- Preview should always show (unless previewer = false)
    width = 0.5,
    height = 0.4,
  },
  border = true,
}

function M.grep_string_v2(opts)
  opts = opts or M.theme()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values

  local search_string = vim.fn.execute "history search"
  local search_list = vim.split(search_string, "\n")
  local results = {}
  for i = #search_list, 3, -1 do
    local item = search_list[i]
    local _, finish = string.find(item, "%d+ +")
    if not vim.tbl_contains(results, string.sub(item, finish + 1)) then
      table.insert(results, string.sub(item, finish + 1))
    end
  end
  pickers.new(opts, {
    prompt_title = "Search",
    finder = finders.new_table(results),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<C-y>", M.custom_actions.import_entry)
      map("n", "<C-y>", M.custom_actions.import_entry)
      map("i", "<C-space>", M.custom_actions.import_entry)
      map("n", "<C-space>", M.custom_actions.import_entry)
      map("i", "<CR>", M.custom_actions.fuzzy_filter_results)
      map("n", "<CR>", M.custom_actions.fuzzy_filter_results)
      return true
    end,
  }):find()
end

M.custom_actions.import_entry = function(prompt_bufnr)
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local current_picker = actions.get_current_picker(prompt_bufnr)
  local entry = action_state.get_selected_entry()

  if entry == false then
    return
  end

  current_picker:reset_prompt()
  if entry ~= nil then
    current_picker:set_prompt(entry.value)
  end
end

M.custom_actions.fuzzy_filter_results = function()
  local action_state = require "telescope.actions.state"
  local query = action_state.get_current_line()

  if not query then
    print "no matching results"
    return
  end

  vim.fn.histadd("search", query)
  -- print(vim.inspect(entry))
  require("telescope.builtin").grep_string {
    search = query,
    prompt_title = "Filter",
    prompt_prefix = "/" .. query .. " >> ",
    preview_title = "Preview",
    layout_config = {
      prompt_position = "bottom",
    },
  }
  vim.cmd [[normal! A]]
end

return M
