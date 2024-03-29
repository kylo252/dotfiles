local M = {}

local colors = {
  bg = "#1C1F24",

  black = "#1B1B1B",
  skyblue = "#51AFEF",

  fg = "#bbc2cf",
  green = "#98BE65",
  oceanblue = "#2257A0",
  magenta = "#C26BDB",
  orange = "#DA8548",
  red = "#FF6C6B",
  violet = "#A9A1E1",
  white = "#EFEFEF",
  yellow = "#ECBE7B",
  dark_yellow = "#D7BA7D",
  cyan = "#4EC9B0",
  light_green = "#B5CEA8",
  string_orange = "#CE9178",
  purple = "#C586C0",
  grey = "#858585",
  blue = "#569CD6",
  vivid_blue = "#4FC1FF",
  light_blue = "#9CDCFE",
  error_red = "#F44747",
  info_yellow = "#FFCC66",
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.o.columns > 100
  end,
}
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local components = {
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    color = {},
    cond = conditions.hide_in_width,
  },
  lsp_clients = {
    function(msg)
      local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end

      local buf_client_names = {}
      local buf_ft = vim.bo.filetype
      local n = require "user.lsp.null-ls"
      for _, client in pairs(buf_clients) do
        if client.name == "null-ls" then
          local null_ls_formatters = n.list_registered_formatters(buf_ft)
          vim.list_extend(buf_client_names, null_ls_formatters)
          local null_ls_linters = n.list_registered_linters(buf_ft)
          vim.list_extend(buf_client_names, null_ls_linters)
        else
          table.insert(buf_client_names, client.name)
        end
      end

      return table.concat(buf_client_names, ", ")
    end,
    color = { gui = "bold" },
  },
  treesitter = {
    function()
      local b = vim.api.nvim_get_current_buf()
      if next(vim.treesitter.highlighter.active[b]) then
        return "  "
      end
      return ""
    end,
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  },
  filename = {
    "filename",
    color = {},
    cond = nil,
    path = 1,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = nil,
  },
}

local config = {
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "NvimTree" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", components.diff },
    lualine_c = { components.filename },
    lualine_x = {
      { "lsp_progress", colors = { use = true } },
      components.diagnostics,
      components.lsp_clients,
      "filetype",
    },
    lualine_y = { components.treesitter },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

function M.setup()
  require("lualine").setup(config)
end

return M
