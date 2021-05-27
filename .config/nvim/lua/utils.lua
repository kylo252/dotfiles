local utils = {}

function utils.define_augroups(definitions) -- {{{1
    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
        vim.cmd('augroup ' .. group_name)
        vim.cmd('autocmd!')

        for _, def in pairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.cmd(command)
        end

        vim.cmd('augroup END')
    end
end

-- lsp

function utils.add_to_workspace_folder()
    vim.lsp.buf.add_workspace_folder()
end

function utils.clear_references()
    vim.lsp.buf.clear_references()
end

function utils.code_action()
    vim.lsp.buf.code_action()
end

function utils.declaration()
    vim.lsp.buf.declaration()
    vim.lsp.buf.clear_references()
end

function utils.definition()
    vim.lsp.buf.definition()
    vim.lsp.buf.clear_references()
end

function utils.document_highlight()
    vim.lsp.buf.document_highlight()
end

function utils.document_symbol()
    vim.lsp.buf.document_symbol()
end

function utils.formatting()
    vim.lsp.buf.formatting()
end

function utils.formatting_sync()
    vim.lsp.buf.formatting_sync()
end

function utils.hover()
    vim.lsp.buf.hover()
end

function utils.implementation()
    vim.lsp.buf.implementation()
end

function utils.incoming_calls()
    vim.lsp.buf.incoming_calls()
end

function utils.list_workspace_folders()
    vim.lsp.buf.list_workspace_folders()
end

function utils.outgoing_calls()
    vim.lsp.buf.outgoing_calls()
end

function utils.range_code_action()
    vim.lsp.buf.range_code_action()
end

function utils.range_formatting()
    vim.lsp.buf.range_formatting()
end

function utils.references()
    vim.lsp.buf.references()
    vim.lsp.buf.clear_references()
end

function utils.remove_workspace_folder()
    vim.lsp.buf.remove_workspace_folder()
end

function utils.rename()
    vim.lsp.buf.rename()
end

function utils.signature_help()
    vim.lsp.buf.signature_help()
end

function utils.type_definition()
    vim.lsp.buf.type_definition()
end

function utils.workspace_symbol()
    vim.lsp.buf.workspace_symbol()
end

-- diagnostic

function utils.get_all()
    vim.lsp.diagnostic.get_all()
end

function utils.get_next()
    vim.lsp.diagnostic.get_next()
end

function utils.get_prev()
    vim.lsp.diagnostic.get_prev()
end

function utils.goto_next()
    vim.lsp.diagnostic.goto_next()
end

function utils.goto_prev()
    vim.lsp.diagnostic.goto_prev()
end

function utils.show_line_diagnostics()
    vim.lsp.diagnostic.show_line_diagnostics()
end

-- git signs

function utils.next_hunk()
    require('gitsigns').next_hunk()
end

function utils.prev_hunk()
    require('gitsigns').prev_hunk()
end

function utils.stage_hunk()
    require('gitsigns').stage_hunk()
end

function utils.undo_stage_hunk()
    require('gitsigns').undo_stage_hunk()
end

function utils.reset_hunk()
    require('gitsigns').reset_hunk()
end

function utils.reset_buffer()
    require('gitsigns').reset_buffer()
end

function utils.preview_hunk()
    require('gitsigns').preview_hunk()
end

function utils.blame_line()
    require('gitsigns').blame_line()
end

-- misc
function utils.file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

return utils

