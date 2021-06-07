require('formatter').setup({
  logging = false,
  filetype = {
    zsh = {
      -- shfmt
      function()
        return {
          exe = "shfmt",
          args = {"-i 2 -ci"},
          stdin = true
        }
      end
    },
    sh = {
      -- shfmt
      function()
        return {
          exe = "shfmt",
          args = {"-i 2 -ci"},
          stdin = true
        }
      end
    },
    lua = {
        -- luafmt
        function()
          return {
            exe = "lua-format",
            args = {"--indent-width=2", "--no-use-tab", "--in-place", "--no-keep-simple-function-one-line", "--column-limit=120"},
            stdin = true
          }
        end
      }
  }
})

