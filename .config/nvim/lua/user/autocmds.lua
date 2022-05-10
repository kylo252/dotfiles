local M = {}

M.augroups = {
  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    { "FileType", "qf", "set nobuflisted" },
    -- { "BufWinEnter", "*", "lua require('core.tmux').set_tmux_win_title('%:t')" },
    { "BufRead", "*", "++once", "lua require('user.lsp').setup()" },
    { "DirChanged", "*", "lua require('user.utils').on_dir_changed()" },
  },
  _git = {
    { "FileType", "gitcommit", "setlocal wrap" },
    { "FileType", "gitcommit", "setlocal spell" },
  },
  _markdown = {
    { "FileType", "markdown", "setlocal wrap" },
    { "FileType", "markdown", "setlocal spell" },
  },
  _buffer_bindings = {
    { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
  },
  _general_windows = {
    { "FileType", "qf,help,man", "nnoremap <silent> <buffer> q :close<CR>" },
    { "FileType", "lspinfo,lsp-installer,null-ls-info", "nnoremap <silent> <buffer> q :close<CR>" },
  },
  _cmp = {
    { "FileType", "TelescopePrompt", [[lua require('cmp').setup.buffer { enabled = false }]] },
  },
}

function M.toggle_format_on_save(opts)
  opts = opts
    or {
      ---@usage pattern string pattern used for the autocommand
      pattern = vim.fn.stdpath "config" .. "/**/*.lua",
      ---@usage timeout number timeout in ms for the format request
      timeout = 1000,
      ---@usage filter func to select client
      filter = function(clients)
        return vim.tbl_filter(function(client)
          local status_ok, method_supported = pcall(function()
            return client.server_capabilities.documentFormattingProvider
          end)
          -- give higher prio to null-ls
          if status_ok and method_supported and client.name == "null-ls" then
            return "null-ls"
          else
            return status_ok and method_supported and client.name
          end
        end, clients)
      end,
    }
  local status, _ = pcall(vim.api.nvim_get_autocmds, {
    group = "lsp_format_on_save",
    event = "BufWritePre",
  })
  if not status then
    -- vim.notify("setting up fmt_on_save", vim.log.levels.DEBUG)
    vim.api.nvim_create_augroup("lsp_format_on_save", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = "lsp_format_on_save",
      pattern = opts.pattern,
      callback = function()
        vim.lsp.buf.format { timeout_ms = opts.timeout, filter = opts.filter }
      end,
    })
  else
    vim.api.nvim_del_augroup_by_name "lsp_format_on_save"
  end
end

--- Disable autocommand groups if it exists
--- This is more reliable than trying to delete the augroup itself
---@param name string the augroup name
function M.disable_augroup(name)
  -- defer the function in case the autocommand is still in-use
  vim.schedule(function()
    if vim.fn.exists("#" .. name) == 1 then
      vim.cmd("augroup " .. name)
      vim.cmd "autocmd!"
      vim.cmd "augroup END"
    end
  end)
end

--- Create autocommand groups based on the passed definitions
---@param definitions table contains trigger, pattern and text. The key will be used as a group name
---@param buffer? boolean indicate if the augroup should be local to the buffer
function M.define_augroups(definitions, buffer)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    if buffer then
      vim.cmd [[autocmd! * <buffer>]]
    else
      vim.cmd [[autocmd!]]
    end

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

function M.setup()
  M.define_augroups(M.augroups)
  vim.api.nvim_create_augroup("lsp_document_highlight", {})
  M.toggle_format_on_save()
  local commands = {
    { name = "ToggleFormatOnSave", fn = require("user.autocmds").toggle_format_on_save },
  }
  require("user.utils").load_commands(commands)
end

return M
