local before_init = function(_, config)
  if vim.env.VIRTUAL_ENV then
    local python_bin = require("lspconfig.util").path.join(vim.env.VIRTUAL_ENV, "bin", "python3")
    config.settings.python.pythonPath = python_bin
  end
end

return {
  -- autostart = false,
  before_init = before_init,
  settings = {
    pylsp = {
      plugins = {
        flake8 = {
          enabled = false,
        },
        pyflakes = {
          enabled = true,
        },
        pycodestyle = {
          enabled = false,
        },
        pylint = {
          enabled = true,
        },
        isort = {
          enabled = true,
        },
        black = {
          enabled = false,
        },
        yapf = {
          enabled = true,
        },
      },
    },
  },
}
