local M = {}

local base_collection = {
  {
    name = "DynamicGrep",
    fn = function(nargs)
      require("core.telescope.custom-finders").dynamic_grep {
        args = nargs.args,
        fargs = nargs.fargs,
      }
    end,
    opts = { nargs = "*" },
  },
  {
    name = "FuzzyGrepString",
    fn = require("core.telescope.custom-finders").fuzzy_grep_string,
    opts = { nargs = "*" },
  },
  {
    name = "FindRuntimeFiles",
    fn = require("core.telescope.custom-finders").find_runtime_files,
  },
  {
    name = "SessionLoad",
    fn = function(nargs)
      require("core.sessions").load_session(nargs.args)
    end,
    opts = {
      nargs = "?",
      complete = require("core.sessions").get_sessions,
    },
  },
  {
    name = "SessionSave",
    fn = function(nargs)
      require("core.sessions").save_session(nargs.args)
    end,
    opts = {
      nargs = "?",
      complete = require("core.sessions").get_sessions,
    },
  },
  { name = "ToggleFormatOnSave", fn = require("user.autocmds").toggle_format_on_save },
}

function M.load_commands(collection)
  local common_opts = { force = true }
  for _, cmd in pairs(collection) do
    local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
  end
end

function M.setup()
  M.load_commands(base_collection)
end

vim.cmd [[
function! Dump(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    new
    nnoremap <silent> <buffer> q :close<CR>
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command Dump call Dump(<q-args>)
]]

return M
