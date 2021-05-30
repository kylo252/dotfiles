vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_section = {
    a = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
    b = {description = {'  Find File          '}, command = 'Telescope find_files'},
    c = {description = {'  DotFiles           '}, command = 'lua require\"config.telescope\".find_dotfiles()'},
    d = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
    n = {description = {'  Load Last Session  '}, command = 'SessionLoad'},
    m = {description = {'  Marks              '}, command = 'Telescope marks'},
    s = {description = {'  Settings           '}, command = ':e ~/.config/nvim/lua/settings.lua'},
}

vim.g.dashboard_session_directory = '~/.cache/nvim/session'
