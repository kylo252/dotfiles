local before_init = function(_, config)
  if vim.env.VIRTUAL_ENV then
    local python_bin = require("lspconfig.util").path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
    config.settings.python.pythonPath = python_bin
  end
end

local root_files = {
  "pyproject.toml",
  "pyrightconfig.json",
  ".git",
}

local util = require "lspconfig.util"
return {
  -- autostart = false,
  root_dir = util.root_pattern(unpack(root_files)),
  before_init = before_init,
  settings = {
    pyright = {},
  },
}
