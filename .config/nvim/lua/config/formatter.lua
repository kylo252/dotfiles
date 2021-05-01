require('formatter').setup({
  logging = false,
  filetype = {
    sh = {
      -- shfmt
      function()
        return {
          exe = "shfmt",
          args = {"-i 2 -ci"},
          stdin = false
        }
      end
    },
  --   lua = {
  --       -- luafmt
  --       function()
  --         return {
  --           exe = "luafmt",
  --           args = {"--indent-count", 2, "--stdin"},
  --           stdin = true
  --         }
  --       end
  --     }
  }
})

