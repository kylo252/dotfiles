local M = {}

local base_definitions = {
  {
    "TextYankPost",
    {
      group = "_general_settings",
      pattern = "*",
      callback = function()
        vim.highlight.on_yank { higroup = "Search", timeout = 200 }
      end,
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = "qf",
      command = "setl nobuflisted",
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = { "gitcommit", "markdown" },
      command = "setl fdm=indent fdl=2 spc= conceallevel=1 list lcs=trail:* tw=100",
    },
  },
  {
    "FileType",
    {
      group = "_buffer_mappings",
      pattern = { "qf", "help", "man", "floaterm", "lspinfo", "lsp-installer", "null-ls-info" },
      command = "nnoremap <silent> <buffer> q :close<CR>",
    },
  },

  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = "TelescopePrompt",
      callback = function()
        require("cmp").setup.buffer { enabled = false }
      end,
    },
  },
  {
    { "BufWinEnter", "BufRead", "BufNewFile" },
    {
      group = "_format_options",
      pattern = "*",
      command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
  },
  {
    "VimResized",
    {
      group = "_auto_resize",
      pattern = "*",
      command = "tabdo wincmd =",
    },
  },
  {
    "DirChanged",
    {
      group = "_general_settings",
      pattern = "*",
      callback = require("user.utils").on_dir_changed,
    },
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

--- Clean autocommand in a group if it exists
--- This is safer than trying to delete the augroup itself
---@param name string the augroup name
function M.clear_augroup(name)
  -- defer the function in case the autocommand is still in-use
  if vim.api.nvim_get_autocmds { group = name } then
    vim.notify("ignoring request to clear autocmds from non-existent group " .. name)
    return
  end
  vim.schedule(function()
    local status_ok, _ = xpcall(function()
      vim.api.nvim_clear_autocmds { group = name }
    end, debug.traceback)
    if not status_ok then
      vim.notify("problems detected while clearing autocmds from " .. name)
    end
  end)
end

--- Create autocommand groups based on the passed definitions
--- Also creates the augroup automatically if it doesn't exist
---@param definitions table contains a tuple of event, opts, see `:h nvim_create_autocmd`
function M.define_autocmds(definitions)
  for _, entry in ipairs(definitions) do
    local event = entry[1]
    local opts = entry[2]
    if type(opts.group) == "string" and opts.group ~= "" then
      local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
      if not exists then
        vim.api.nvim_create_augroup(opts.group, {})
      end
    end
    vim.api.nvim_create_autocmd(event, opts)
  end
end

function M.setup()
  M.define_autocmds(base_definitions)
  M.toggle_format_on_save()
  vim.filetype.add { extension = { ["rasi"] = "rasi" } }
end

return M
