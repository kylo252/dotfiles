local M = {}

local scratch_file = vim.fn.stdpath "config" .. "/lua/scratch.lua"

local header = {
  type = "text",
  val = {
    "",
    "",
    " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    "",
    "",
    "",
  },
  opts = {
    position = "center",
    hl = "String",
  },
}

local footer = {
  type = "text",
  -- val = {},
  opts = {
    position = "center",
    hl = "Number",
  },
}

local buttons = {
  entries = {
    { "SPC f f", "󰈞  Find File", "<CMD>Telescope find_files<CR>" },
    { "SPC f r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
    { "SPC f l", "  Find Word", "<CMD>Telescope live_grep<CR>" },
    { "SPC f j", "  Recent Places", "<CMD>Telescope zoxide list<CR>" },
    { "SPC P", "  Recent Projects", "<CMD>Telescope projects<CR>" },
    { "SPC e", "  New File", "<CMD>ene!<CR>" },
    { "SPC R", "󰀘  Load Session", "<CMD>SessionLoad<cr>" },
    { "SPC p", "  Plugins ", "<cmd>edit ~/.config/nvim/lua/user/plugins.lua<cr>" },
    { "SPC s", "  Scratch", "<CMD>edit " .. scratch_file .. "<CR>" },
  },
}

local section = {
  header = header,
  footer = footer,
  buttons = buttons,
}

function M.setup()
  local alpha = require "alpha"
  local dashboard = require "alpha.themes.dashboard"

  dashboard.section.buttons.val = {}

  for _, entry in pairs(section.buttons.entries) do
    local button = require("alpha.themes.dashboard").button
    table.insert(dashboard.section.buttons.val, button(entry[1], entry[2], entry[3]))
  end

  dashboard.section.header.val = section.header.val
  dashboard.section.header.opts.hl = section.header.opts.hl
  -- dashboard.section.footer.val = conf.footer.val
  alpha.setup(dashboard.config)
end

return M
