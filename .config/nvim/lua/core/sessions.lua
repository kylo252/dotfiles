vim.g.auto_session_root_dir = os.getenv "HOME" .. "/.cache/nvim/sessions"

local opts = {
  log_level = "info",
  auto_session_enable_last_session = false,
  auto_session_root_dir = os.getenv "HOME" .. "/.cache/nvim/sessions",
  auto_session_enabled = false,
  auto_save_enabled = false,
  auto_restore_enabled = false,
  auto_session_suppress_dirs = nil,
}

require("auto-session").setup(opts)
