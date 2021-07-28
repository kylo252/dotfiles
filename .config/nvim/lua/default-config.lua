CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"

local EFM_CONF_PATH = os.getenv "HOME" .. "/.config/efm-langserver/config.yaml"

if vim.fn.empty(vim.fn.glob(EFM_CONF_PATH)) > 0 then
  EFM_CONF_PATH = CONFIG_PATH .. "/utils/efm-config.yaml"
end

O = {
  sessions_dir = os.getenv "HOME" .. "/.cache/nvim/sessions",
  efm_conf_path = EFM_CONF_PATH,
  lang = {
    c = {},
    cpp = {},
    json = {},
    lua = {},
    python = {},
    sh = {},
    zsh = {},
  },
}
