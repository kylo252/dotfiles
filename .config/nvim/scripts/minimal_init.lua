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

-- Choose whether to use the executable that's managed by lsp-installer
local use_lsp_installer = true

local function load_plugins()
  require("packer").startup {
    {
      "wbthomason/packer.nvim",
      "neovim/nvim-lspconfig",
      { "williamboman/nvim-lsp-installer", disable = not use_lsp_installer },
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
  return ...
end

_G.load_config = function()
  vim.lsp.set_log_level "trace"
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
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>li", "<cmd>LspInfo<CR>", opts)
    vim.keymap.set("n", "<space>lI", "<cmd>LspInstallInfo<CR>", opts)
  end

  -- Add the server that troubles you here, e.g. "sumneko_lua", "pyright", "tsserver"
  local servers = {
    "zk",
    -- "prosemd_lsp",
    "ltex",
  }

  local setup_opts = {
    on_attach = on_attach,
  }

  for _, name in ipairs(servers) do
    if use_lsp_installer then
      local server_available, server = require("nvim-lsp-installer.servers").get_server(name)
      if not server_available then
        server:install()
      end
      local default_opts = server:get_default_options()
      setup_opts = vim.tbl_deep_extend("force", setup_opts, default_opts)
    end

    nvim_lsp[name].setup(setup_opts)
  end
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  load_plugins()
  require("packer").sync()
  vim.cmd [[autocmd User PackerComplete ++once lua load_config()]]
else
  load_plugins()
  require("packer").sync()
  _G.load_config()
end
