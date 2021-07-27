require("formatter").setup {
  logging = false,
  filetype = {
    zsh = {
      -- shfmt
      function()
        return { exe = "shfmt", args = { "-i 2 -ci" }, stdin = true }
      end,
    },
    sh = {
      -- shfmt
      function()
        return { exe = "shfmt", args = { "-i 2 -ci" }, stdin = true }
      end,
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = {},
          stdin = false,
        }
      end,
    },
  },
}
