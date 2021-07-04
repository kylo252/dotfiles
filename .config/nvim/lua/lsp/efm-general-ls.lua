-- lua
local luaFormat = {
  formatCommand = "lua-format -i --indent-width=2 --no-use-tab --no-keep-simple-function-one-line --column-limit=120",
  formatStdin = true
}
local lua_arguments = {luaFormat}

table.insert(lua_arguments, luaFormat)

--[[ require"lspconfig".efm.setup {
    -- init_options = {initializationOptions},
    cmd = {DATA_PATH .. "/lspinstall/efm/efm-langserver"},
    init_options = {documentFormatting = true, codeAction = false},
    filetypes = {"lua", "python", "javascriptreact", "javascript", "sh", "zsh", "html", "css", "json", "yaml", "markdown"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = python_arguments,
            lua = lua_arguments,
            sh = sh_arguments,
            zsh = sh_arguments,
            javascript = tsserver_args,
            javascriptreact = tsserver_args,
            html = {prettier},
            css = {prettier},
            json = {prettier},
            yaml = {prettier},
            markdown = {markdownPandocFormat}
            -- javascriptreact = {prettier, eslint},
            -- javascript = {prettier, eslint},
            -- markdown = {markdownPandocFormat, markdownlint},
        }
    }
} ]]

-- Also find way to toggle format on save
-- maybe this will help: https://superuser.com/questions/439078/how-to-disable-autocmd-or-augroup-in-vim


