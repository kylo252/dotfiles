local M = {}

M.augroups = {
  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    { "FileType", "qf", "set nobuflisted" },
    { "BufWinEnter", "*", "lua require('core.tmux').set_tmux_win_title('%:t')" },
    { "BufRead", "*", "++once", "lua require('user.lsp').setup()" },
    { "DirChanged", "*", "lua require('user.utils').on_dir_changed()" },
  },
  _filetypechanges = {
    { "BufWinEnter", ".zsh", "setlocal filetype=sh" },
    { "BufRead", "*.zsh", "setlocal filetype=sh" },
    { "BufNewFile", "*.zsh", "setlocal filetype=sh" },
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
    }
  if vim.fn.exists "#fmt_on_save#BufWritePre" == 0 then
    local fmd_cmd = string.format(":silent lua vim.lsp.buf.formatting_sync({}, %s)", opts.timeout_ms)
    M.define_augroups {
      fmt_on_save = { { "BufWritePre", opts.pattern, fmd_cmd } },
    }
  else
    vim.cmd "au! fmt_on_save"
    vim.notify("disabled fmt_on_save", vim.log.levels.INFO)
  end
end

function M.enable_lsp_document_highlight(client_id)
  M.define_augroups({
    lsp_document_highlight = {
      {
        "CursorHold",
        "<buffer>",
        string.format("lua require('user.lsp.utils').conditional_document_highlight(%d)", client_id),
      },
      {
        "CursorMoved",
        "<buffer>",
        "lua vim.lsp.buf.clear_references()",
      },
    },
  }, true)
end

function M.disable_lsp_document_highlight()
  M.disable_augroup "lsp_document_highlight"
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
---@param buffer boolean indicate if the augroup should be local to the buffer
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
  M.toggle_format_on_save()
  local commands = {
    { name = "ToggleFormatOnSave", fn = require("user.autocmds").toggle_format_on_save },
  }
  require("user.utils").load_commands(commands)
end

return M
