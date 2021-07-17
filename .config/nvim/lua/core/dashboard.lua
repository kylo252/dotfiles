vim.g.dashboard_default_executive = "telescope"

vim.g.dashboard_custom_section = {
  a = { description = { "  Recently Used Files" }, command = "Telescope oldfiles" },
  b = { description = { "  Find File          " }, command = "Telescope find_files" },
  c = { description = { "  Plugins            " }, command = ":edit ~/.config/nvim/lua/plugins.lua" },
  s = { description = { "  Settings           " }, command = ":edit ~/.config/nvim/lua/settings.lua" },
  d = { description = { "  Find Word          " }, command = "Telescope live_grep" },
  n = { description = { "  Load Last Session  " }, command = "SessionLoad" },
  m = { description = { "  Marks              " }, command = "Telescope marks" },
}

vim.g.dashboard_session_directory = O.sessions_dir
-- vim.cmd("let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))")

-- vim.api.nvim_exec([[
-- let g:dashboard_custom_footer = ['LuaJIT loaded '..packages..' plugins']
-- ]], false)

--[[ require('utils').define_augroups({
    _dashboard = {
        -- seems to be nobuflisted that makes my stuff disapear will do more testing
        {
            'FileType', 'dashboard',
            'setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= '
        }, {
            'FileType', 'dashboard',
            'set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2'
        }, {'FileType', 'dashboard', 'nnoremap <silent> <buffer> q :q<CR>'}
    }
}) ]]
