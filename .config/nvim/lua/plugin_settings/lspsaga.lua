local nvim_lsp = require('lspconfig')
local wk = require("whichkey_setup")
local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local keymap = {
        l = {
            name = "+lsp",
            -- workspace
            a = {'<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'add workspace'},
            r = {'<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'remove workspace'},
            l = {'<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'list workspace'},
            -- show
            d = {"<Cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR> ", 'diagnostics'},
            -- float terminal also you can pass the cli command in open_float_terminal function
            g = {"<Cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR>", 'lazygit'},
            -- toggle virtual text
            v = {'<Cmd>lua require("funcs.virtual_text").toggle()<CR>', 'virtual text'},
            -- code action
            q = {"<Cmd>lua require('lspsaga.codeaction').code_action()<CR>", 'code action'},
        },
        r = {
            name = "+rename",
            -- rename
            n = {"<Cmd>lua require('lspsaga.rename').rename()<CR>", 'rename'},
        },
    }
    local visual_keymap = {l = {
        name = "+lsp",
        q = {"<Cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", 'code action'},
    }}
    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        keymap.l.f = {"<Cmd>lua vim.lsp.buf.formatting()<CR>", 'format'}
    elseif client.resolved_capabilities.document_range_formatting then
        keymap.l.f = {"<Cmd>lua vim.lsp.buf.range_formatting()<CR>", 'format'}
    end
    wk.register_keymap('leader', keymap, {noremap=true, silent=true, bufnr=bufnr})
    wk.register_keymap('visual', visual_keymap, {noremap=true, silent=true, bufnr=bufnr})

    -- saga mappings
    -- lsp provider to find the cursor word definition and reference
    buf_set_keymap('n', 'gh', "<Cmd>lua require('lspsaga.provider').lsp_finder()<CR>", opts)
    -- show hover doc
    buf_set_keymap('n', 'K', "<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
    -- scroll down hover doc or scroll in definition preview
    buf_set_keymap('n', '<C-f>', "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
    -- scroll up hover doc
    buf_set_keymap('n', '<C-b>', "<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
    -- show signature help
    buf_set_keymap('n', 'gs', "<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
    -- preview definition
    buf_set_keymap('n', 'gp', "<Cmd>lua require'lspsaga.provider'.preview_definition()<CR>", opts)
    buf_set_keymap('n', 'gd', "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap('n', 'gD', "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- jump diagnostic
    buf_set_keymap('n', '[g', "<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
    buf_set_keymap('n', ']g', "<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            " TODO handle this
            " hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
            " hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
            " hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua require('lspsaga.diagnostic').show_cursor_diagnostics()
                " autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end

-- enable snippets
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
    pyright = {},
    rust_analyzer = {},
    vimls = {},
    bashls = {},
    dockerls = {},
    jsonls = {},
    kotlin_language_server = {},
    texlab = {},
    yamlls = {},
    html = {},
    ccls = {
        init_options = {compilationDatabaseDirectory = "build"},
    },
    sumneko_lua = {
        cmd = {'lua-language-server'},
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {globals = {'vim'}},
                workspace = {
                    library = {
                      [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                      [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        },
    },
    -- linters + formatters
    efm = {
        cmd = {'efm-langserver'},
        init_options = {documentFormatting = true},
        filetypes = {
            "lua",
            "python",
            "vim",
            "make",
            "markdown",
            "rst",
            "yaml",
            "dockerfile",
            "sh",
            "json",
        },
    },
}
for lsp, setup in pairs(servers) do
    setup.on_attach = on_attach
    setup.capabilities = capabilities
    nvim_lsp[lsp].setup(setup)
end

local saga = require('lspsaga')
saga.init_lsp_saga()
vim.api.nvim_set_keymap('n', '<A-d>', '<Cmd>lua require("lspsaga.floaterm").open_float_terminal()<CR>', opts)
vim.api.nvim_set_keymap('t', '<A-d>', [[<C-\><C-n>:lua require("lspsaga.floaterm").close_float_terminal()<CR>]], opts)

-- TODO move elsewhere?
vim.cmd('highlight! link LspDiagnosticsDefaultError WarningMsg')
vim.fn.sign_define("LspDiagnosticsSignError", {
    texthl = "LspDiagnosticsSignError",
    text = "",
    numhl = "LspDiagnosticsSignError",
})
vim.fn.sign_define("LspDiagnosticsSignWarning", {
    texthl = "LspDiagnosticsSignWarning",
    text = "",
    numhl = "LspDiagnosticsSignWarning"
})
vim.fn.sign_define("LspDiagnosticsSignInformation", {
    texthl = "LspDiagnosticsSignInformation",
    text = "",
    numhl = "LspDiagnosticsSignInformation"
})
vim.fn.sign_define("LspDiagnosticsSignHint", {
    texthl = "LspDiagnosticsSignHint",
    text = "",
    numhl = "LspDiagnosticsSignHint"
})
