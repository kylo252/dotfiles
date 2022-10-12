-- avoid problems with old `gcc` on RHEL7
local M = {}
function M.setup()
  require("nvim-treesitter.install").compilers = { "clang", "gcc" }

  require("nvim-treesitter.configs").setup {
    ensure_installed = { "bash", "lua", "c", "cpp", "vim", "json", "yaml", "python", "comment" },
    highlight = { enable = true },
    indent = { enable = true, disable = { "python", "yaml" } },
    autotag = { enable = true },
    rainbow = { enable = false },
    incremental_selection = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ak"] = "@comment.outer",
          ["aa"] = "@parameter.inner", -- "ap" is already used
          ["ia"] = "@parameter.outer", -- "ip" is already used
        },
      },
      lsp_interop = {
        enable = true,
        border = "rounded",
        peek_definition_code = {
          ["gpof"] = "@function.outer",
          ["gpoc"] = "@class.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
          ["]k"] = "@comment.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
          ["]K"] = "@comment.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
          ["[k"] = "@comment.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
          ["[K"] = "@comment.outer",
        },
      },
    },
  }
end

return M
