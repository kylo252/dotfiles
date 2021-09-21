local M = {}

function M.setup()
  local signs = {
    { name = "LspDiagnosticsSignError", text = "" },
    { name = "LspDiagnosticsSignWarning", text = "" },
    { name = "LspDiagnosticsSignHint", text = "" },
    { name = "LspDiagnosticsSignInformation", text = "" },
  }
  local config = {
    virtual_text = false,
    signs = signs,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
  }
  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)
    if not bufnr then
      return
    end

    local diagnostics = result.diagnostics
    local ok, vim_diag = pcall(require, "vim.diagnostic")
    if ok then
      -- FIX: why can't we just use vim.diagnostic.get(buf_id)?
      config.signs = true
      for i, diagnostic in ipairs(diagnostics) do
        local rng = diagnostic.range
        diagnostics[i].lnum = rng["start"].line
        diagnostics[i].end_lnum = rng["end"].line
        diagnostics[i].col = rng["start"].character
        diagnostics[i].end_col = rng["end"].character
      end
      local namespace = vim.lsp.diagnostic.get_namespace(ctx.client_id)

      vim_diag.set(namespace, bufnr, diagnostics, config)
      if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
      end

      local sign_names = {
        "DiagnosticSignError",
        "DiagnosticSignWarn",
        "DiagnosticSignInfo",
        "DiagnosticSignHint",
      }
      for i, sign in ipairs(signs) do
        vim.fn.sign_define(sign_names[i], { texthl = sign_names[i], text = sign.text, numhl = "" })
      end

      vim_diag.show(namespace, bufnr, diagnostics, config)
    else
      vim.lsp.diagnostic.save(diagnostics, bufnr, ctx.client_id)
      if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
      end
      vim.lsp.diagnostic.display(diagnostics, bufnr, ctx.client_id, config)
    end
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
end

function M.show_line_diagnostics()
  local diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
  local severity_highlight = {
    "LspDiagnosticsFloatingError",
    "LspDiagnosticsFloatingWarning",
    "LspDiagnosticsFloatingInformation",
    "LspDiagnosticsFloatingHint",
  }
  local ok, vim_diag = pcall(require, "vim.diagnostic")
  if ok then
    local buf_id = vim.api.nvim_win_get_buf(0)
    local win_id = vim.api.nvim_get_current_win()
    local cursor_position = vim.api.nvim_win_get_cursor(win_id)
    severity_highlight = {
      "DiagnosticFloatingError",
      "DiagnosticFloatingWarn",
      "DiagnosticFloatingInfo",
      "DiagnosticFloatingHint",
    }
    diagnostics = vim_diag.get(buf_id, { lnum = cursor_position[1] - 1 })
  end
  local diags = vim.deepcopy(diagnostics)
  local height = #diagnostics
  local width = 0
  local opts = {}
  local close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" }
  if height == 0 then
    return
  end
  local bufnr = vim.api.nvim_create_buf(false, true)

  for i, diagnostic in ipairs(diagnostics) do
    local source = diagnostic.source
    if source then
      if string.find(source, "/") then
        source = string.sub(diagnostic.source, string.find(diagnostic.source, "([%w-_]+)$"))
      end
      diags[i].message = string.format("%s: %s", source, diagnostic.message)
    else
      diags[i].message = string.format("%s", diagnostic.message)
    end

    if diagnostic.code then
      diags[i].message = string.format("%s [%s]", diags[i].message, diagnostic.code)
    end
    if diags[i].message:len() > width then
      width = string.len(diags[i].message)
    end
  end

  opts = vim.lsp.util.make_floating_popup_options(width, height, opts)
  opts["style"] = "minimal"
  opts["border"] = "rounded"

  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
  local winnr = vim.api.nvim_open_win(bufnr, false, opts)
  vim.api.nvim_win_set_option(winnr, "winblend", 0)
  vim.api.nvim_buf_set_var(bufnr, "lsp_floating_window", winnr)
  for i, diag in ipairs(diags) do
    local message = diag.message:gsub("[\n\r]", " ")
    vim.api.nvim_buf_set_lines(bufnr, i - 1, i - 1, 0, { message })
    vim.api.nvim_buf_add_highlight(bufnr, -1, severity_highlight[diag.severity], i - 1, 0, diag.message:len())
  end

  vim.api.nvim_command(
    "autocmd QuitPre <buffer> ++nested ++once lua pcall(vim.api.nvim_win_close, " .. winnr .. ", true)"
  )
  vim.lsp.util.close_preview_autocmd(close_events, winnr)
end

return M
