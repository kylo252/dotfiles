local M = {}

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

function M.setup()
  require("bqf").setup {
    auto_enable = true,
    preview = {
      auto_preview = false,
    },
  }
end

return M
