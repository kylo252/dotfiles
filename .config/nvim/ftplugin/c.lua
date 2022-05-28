local u = require "user.utils"
if u.is_file "src/uncrustify.cfg" then
  vim.cmd [[
    setlocal formatprg=uncrustify\ -q\ -l\ C\ -c\ src/uncrustify.cfg\ --no-backup
  ]]
end
