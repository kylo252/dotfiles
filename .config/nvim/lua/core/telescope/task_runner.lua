---@diagnostic disable: unused-local, unused-function
--luacheck: ignore 211 212

local M = {
  custom_actions = {},
}

require("plenary.reload").reload_module "task_runner"

local builtin = require "telescope.builtin"
local lsp_finder = require "telescope.builtin.lsp"
local themes = require "telescope.themes"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local project_dir = vim.fn.getcwd()
local filetype = vim.bo.filetype
local file_relative_path = vim.fn.expand "%"
local file_dirname = vim.fn.expand "%:h:p"
local file_base_name = vim.fn.expand "%:t"
local file_base_name_no_ext = vim.fn.expand "%:t:r"
local word_under_cursor = vim.fn.expand "<cWORD>"
local selected_text = ""

local function get_test_pattern(entry)
  local pattern = {
    "go",
    "test",
    -- project_dir,
    file_relative_path,
    "-run",
    entry,
  }
  return pattern
end

local function run_term(cmd)
  local cmd_str = table.concat(cmd, " ")
  -- TODO: this might not be working as expected
  local term_opts = {
    cmd = "echo please let me run in a split",
    close_on_exit = false,
    -- open_mapping = lvim.log.viewer.layout_config.open_mapping,
    -- direction = lvim.log.viewer.layout_config.direction,
    -- size = lvim.log.viewer.layout_config.size,
    -- float_opts = lvim.log.viewer.layout_config.float_opts,
  }

  local Terminal = require("toggleterm.terminal").Terminal
  local tester_view = Terminal:new(term_opts)
  -- require("core.log"):debug("term", vim.inspect(term_opts))
  tester_view:toggle()
end

local function run_tmux(cmd)
  local tmux_opts = "-v -p30"
  local cmd_str = table.concat(cmd, " ")
  local dummy_run = false
  local exec_cmd
  local postfix = [[; while [ : ]; do sleep 1; done]]
  if dummy_run then
    exec_cmd = string.format([[ echo executing [ %q ] ]], cmd_str)
  else
    exec_cmd = string.format([[ echo executing [ %q ]; '%q' ]], cmd_str, cmd_str)
  end
  vim.cmd(
    string.format([[silent !tmux split-window %s bash -c '%s %s']], tmux_opts, exec_cmd, postfix)
  )
end

function M.run_function_under_cursor()
  local cmd = get_test_pattern(word_under_cursor)
  run_tmux(cmd)
end

function M.find_test_file()
  builtin.find_files(themes.get_ivy {
    prompt_title = "~ test files ~",
    cwd = vim.fn.getcwd(),
    find_command = { "fd", "-i", file_base_name_no_ext, "-e=mk" },
    attach_mappings = function(_, map)
      map("i", "<CR>", M.custom_actions.run_make_test)
      return true
    end,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      width = 0.5,
      height = 15,
    },
  })
end

function M.find_test_function()
  lsp_finder.document_symbols(themes.get_ivy {
    prompt_title = "~ test functions ~",
    cwd = vim.fn.getcwd(),
    symbols = "function",
    attach_mappings = function(_, map)
      map("i", "<CR>", M.custom_actions.run_test)
      return true
    end,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      width = 0.5,
      height = 15,
    },
  })
end

M.custom_actions.run_test = function(prompt_bufnr)
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local entry = action_state.get_selected_entry().value.text:gsub("%[Function%] ", "")

  local cmd = get_test_pattern(entry)
  run_tmux(cmd)
  actions.close(prompt_bufnr)
end

M.custom_actions.open_test_file = function(prompt_bufnr)
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local entry = action_state.get_selected_entry().value
  if not entry then
    print "no matching results"
    return
  end
  local cmd = {
    "make",
    "-j$(nproc)",
    "-C",
    "test/unitTest",
    string.format("UTDB=%q/%q", project_dir, entry),
    "run_all",
  }
  local cmd_str = table.concat(cmd, " ")
  vim.cmd("silent !tmux splitw -v -p30 '" .. cmd_str .. "; read'")
  actions.close(prompt_bufnr)
end

M.custom_actions.run_make_test = function(prompt_bufnr)
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local entry = action_state.get_selected_entry().value
  if not entry then
    print "no matching results"
    return
  end
  local cmd = {
    "make",
    "-j$(nproc)",
    "-C",
    "test/unitTest",
    string.format("UTDB=%q/%q", project_dir, entry),
    "run_all",
  }
  local cmd_str = string.format("bash -c 'echo %q; read'", table.concat(cmd, " "))
  vim.cmd("silent !tmux splitw -v -p30 '" .. cmd_str .. "; read'")
  actions.close(prompt_bufnr)
end

local wk = require "which-key"

local keymaps = {
  name = "+Tests",
  f = {
    "<cmd>lua package.loaded['task_runner'] = nil; require('task_runner').find_test_function()<cr>",
    "find test function",
  },
  u = {
    "<cmd>lua package.loaded['task_runner'] = nil; require('task_runner').run_function_under_cursor()<cr>",
    "run function under cursor (WIP)",
  },
  t = {
    "<cmd>lua require('task_runner').find_test_function()<cr>",
    "find test function",
  },
}
local opts = {
  prefix = "<leader>,",
  mode = "n", -- NORMAL mode
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
wk.register(keymaps, opts)

return M
