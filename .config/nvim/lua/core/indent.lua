local M = {}

function M.setup()
  local opts = {
    char = "┊",
    filetype_exclude = {
      "alpha",
      "help",
      "terminal",
      "dashboard",
      "lspinfo",
      "lsp-installer",
      "mason",
    },
    buftype_exclude = { "terminal" },

    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_end_of_line = true,
    show_current_context = true,
    show_current_context_start = true,
    char_blankline = "┊",
    context_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
  }

  require("indent_blankline").setup(opts)
end

return M
