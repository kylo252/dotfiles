local M = {}

local custom_actions = require "core.telescope.custom-actions"

local _, builtin = pcall(require, "telescope.builtin")
local _, finders = pcall(require, "telescope.finders")
local _, pickers = pcall(require, "telescope.pickers")
local _, sorters = pcall(require, "telescope.sorters")
local _, themes = pcall(require, "telescope.themes")

function M.grep_string_v2(opts)
  opts = opts or M.theme()

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
    sorter = sorters.fuzzy_with_index_bias,
    attach_mappings = function(_, map)
      map("i", "<C-y>", custom_actions.import_entry)
      map("n", "<C-y>", custom_actions.import_entry)
      map("i", "<C-space>", custom_actions.import_entry)
      map("n", "<C-space>", custom_actions.import_entry)
      map("i", "<CR>", custom_actions.fuzzy_filter_results)
      map("n", "<CR>", custom_actions.fuzzy_filter_results)
      return true
    end,
  }):find()
end

function M.fuzzy_grep_string(query)
  query = query or {}
  builtin.grep_string(themes.get_ivy {
    prompt_title = "Fuzzy grep string, initial query: " .. query,
    search = query,
  })
end

function M.live_grep_v2(opts)
  opts = opts or {}
  builtin.live_grep(vim.tbl_deep_extend("force", {
    prompt_title = "Search",
    attach_mappings = function(_, map)
      map("i", "<C-g>", custom_actions.fuzzy_filter_results)
      map("n", "<C-g>", custom_actions.fuzzy_filter_results)
      return true
    end,
  }, opts))
end

function M.grep_dotfiles()
  M.live_grep_v2 {
    search_dirs = { vim.fn.stdpath "config", os.getenv "ZDOTDIR" },
    hidden = true,
  }
end

function M.find_dotfiles()
  local opts = themes.get_ivy {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 15,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ dotfiles ~",
    cwd = "~",
    find_command = { "git", "dots", "ls-files" },
  }
  require("telescope.builtin").find_files(opts)
end

return M