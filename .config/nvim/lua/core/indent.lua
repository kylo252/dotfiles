local M = {}

function M.setup()
  local opts = {
    indent = { char = "┊" },
    exclude = {
      filetypes = {
        "alpha",
        "checkhealth",
        "dashboard",
        "gitcommit",
        "help",
        "lspinfo",
        "lsp-installer",
        "man",
        "mason",
        "packer",
        "TelescopePrompt",
        "TelescopeResults",
        "terminal",
        "",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
    scope = {
      enabled = true,
      char = nil,
      show_start = true,
      show_end = true,
      injected_languages = true,
    },
  }

  require("ibl").setup(opts)
end

return M
