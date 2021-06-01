local wk = require('which-key')
local opts = {silent=true, noremap=true, prefix="<leader>" }

local keymap = {
    t = {
        name = '+trouble',
        t = {"<cmd>Trouble<CR>", "toggle trouble"},
        w = {"<cmd>Trouble lsp_workspace_diagnostics<CR>", "toggle workspace diagnostics"},
        d = {"<cmd>Trouble lsp_document_diagnostics<CR>", "toggle document diagnostics"},
        l = {"<cmd>Trouble loclist<CR>", "toggle loclist"},
        r = {"<cmd>Trouble lsp_references<CR>", "toggle references"},
        q = {"<cmd>Trouble quickfix<CR>", "toggle quickfix"},
    }
}

    -- -- QuickFix list
    -- {'<Leader>tt', ':cnext<CR>'},
    -- {'<Leader>tr', ':cprevious<CR>'},
wk.register(keymap, opts)

require("trouble").setup({
  mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
})
