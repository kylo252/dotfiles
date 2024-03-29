local on_windows = vim.loop.os_uname().version:match "Windows"

local function join_paths(...)
  local path_sep = on_windows and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.cmd [[set runtimepath=$VIMRUNTIME]]

local temp_dir = vim.loop.os_getenv "TEMP" or "/tmp"

vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))

local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

-- Choose whether to use the executable that's managed by mason
local use_mason = true

local function load_plugins()
  require("packer").startup {
    {
      "wbthomason/packer.nvim",
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

local load_config = function()
  vim.lsp.set_log_level "trace"
  vim.cmd [[syntax off]]
  require("vim.lsp.log").set_format_func(vim.inspect)
  local nvim_lsp = require "lspconfig"
  local on_attach = function(_, bufnr)
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>lD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<space>li", "<cmd>LspInfo<CR>", opts)
    vim.keymap.set("n", "<space>lI", "<cmd>Mason<CR>", opts)
    vim.keymap.set("n", "<space>ll", vim.fn.execute("edit " .. vim.lsp.get_log_path()), opts)
  end

  -- Add the server that troubles you here, e.g. "clangd", "pyright", "tsserver"
  local name = "clangd"

  local setup_opts = {
    on_attach = on_attach,
  }

  if not name then
    print "You have not defined a server name, please edit minimal_init.lua"
  end
  if not nvim_lsp[name].document_config.default_config.cmd and not setup_opts.cmd then
    print [[You have not defined a server default cmd for a server
      that requires it please edit minimal_init.lua]]
  end

  nvim_lsp[name].setup(setup_opts)
  if use_mason then
    require("mason-lspconfig").setup { automatic_installation = true }
  end

  print [[You can find your log at $HOME/.cache/nvim/lsp.log. Please paste in a github issue under a details tag as described in the issue template.]]
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  load_plugins()
  require("packer").sync()
  local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
  vim.api.nvim_create_autocmd(
    "User",
    { pattern = "PackerComplete", callback = load_config, group = packer_group, once = true }
  )
else
  load_plugins()
  require("packer").sync()
  load_config()
end
