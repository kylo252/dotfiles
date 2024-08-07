local M = {}
local join_paths = require("user.utils").join_paths

function M.setup()
  local opts = {
    PATH = "prepend",
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    ui = {
      install_root_dir = join_paths(vim.fn.stdpath "data", "mason"),
      check_outdated_packages_on_open = false,
      border = "rounded",
      keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "X",
        cancel_installation = "<C-c>",
        apply_language_filter = "<C-f>",
        toggle_package_install_log = "<CR>",
        toggle_help = "g?",
      },
    },
    github = {
      -- The template URL to use when downloading assets from GitHub.
      -- The placeholders are the following (in order):
      -- 1. The repository (e.g. "rust-lang/rust-analyzer")
      -- 2. The release version (e.g. "v0.3.0")
      -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
      download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
  }

  require("mason").setup(opts)

  local ls_opts = { automatic_installation = { exclude = { "clangd" } } }

  require("user.lsp").setup()
  require("mason-lspconfig").setup(ls_opts)
end

return M
