local M = {}

local base_definitions = {
  {
    "TextYankPost",
    {
      group = "_general_settings",
      pattern = "*",
      desc = "Highlight text on yank",
      callback = function()
        vim.highlight.on_yank { higroup = "Search", timeout = 200 }
      end,
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = { "gitcommit", "markdown" },
      command = "setl fdm=indent fdl=4 spc= cole=1 cocu=nc list lcs=trail:* tw=100",
    },
  },
  {
    "FileType",
    {
      group = "_buffer_mappings",
      pattern = {
        "qf",
        "help",
        "man",
        "floaterm",
        "lspinfo",
        "lir",
        "lsp-installer",
        "null-ls-info",
        "tsplayground",
      },
      callback = function()
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
        vim.opt_local.buflisted = false
      end,
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
  {
    "DirChanged",
    {
      group = "_general_settings",
      pattern = "*",
      desc = "set osc7 so that tmux can see it",
      command = [[call chansend(v:stderr, printf("\033]7;%s\033", v:event.cwd))]],
    },
  },
  {
    "ExitPre",
    {
      group = "_general_settings",
      pattern = "*",
      desc = "reset cursor back when leaving Neovim",
      command = "set guicursor=a:ver90",
    },
  },
}

function M.toggle_format_on_save(opts)
  opts = opts
    or {
      ---used for the autocommand, see |autpat|
      pattern = vim.fn.stdpath "config" .. "/**/*.lua",
      ---time in ms for the format request
      timeout = 1000,
      ---function to select client
      filter = function(clients)
        return vim.tbl_filter(function(client)
          local status_ok, method_supported = pcall(function()
            return client.server_capabilities.documentFormattingProvider
          end)
          -- give higher prio to null-ls
          if status_ok and method_supported and client.name == "null-ls" then
            return true
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

function M.hide_eol()
  vim.opt.conceallevel = 3
  vim.opt.concealcursor = "nvic"
  vim.api.nvim_set_hl(0, "Ignore", { ctermfg = 15, fg = "bg" })
  vim.api.nvim_create_autocmd("BufReadPost", {
    buffer = 0,
    command = "match Ignore /\r$/",
  })
  vim.cmd ":e"
end

function M.setup()
  M.define_autocmds(base_definitions)
  M.toggle_format_on_save()
  vim.filetype.add { extension = { ["rasi"] = "rasi" } }
end

return M
