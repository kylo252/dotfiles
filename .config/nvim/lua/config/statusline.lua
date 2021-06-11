local gl = require('galaxyline')
local section = require('galaxyline').section
local condition = require('galaxyline.condition')

local colors = {
  bg = '#1C1F24',

  black = '#1B1B1B',
  skyblue = '#51AFEF',

  fg = '#bbc2cf',
  green = '#98BE65',
  oceanblue = '#2257A0',
  magenta = '#C26BDB',
  orange = '#DA8548',
  red = '#FF6C6B',
  violet = '#A9A1E1',
  white = '#EFEFEF',
  yellow = '#ECBE7B',
  dark_yellow = '#D7BA7D',
  cyan = '#4EC9B0',
  light_green = '#B5CEA8',
  string_orange = '#CE9178',
  purple = '#C586C0',
  grey = '#858585',
  blue = '#569CD6',
  vivid_blue = '#4FC1FF',
  light_blue = '#9CDCFE',
  error_red = '#F44747',
  info_yellow = '#FFCC66'
}

local mode_color = function()
  -- auto change color according the vim mode
  local mode_colors = {
    n = colors.blue,
    i = colors.green,
    v = colors.purple,
    [''] = colors.purple,
    V = colors.purple,
    c = colors.magenta,
    no = colors.blue,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.red,
    Rv = colors.red,
    cv = colors.blue,
    ce = colors.blue,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.blue,
    t = colors.blue
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then color = colors.red end

  return color
end

gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

table.insert(section.left, {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        V = 'VISUAL',
        [''] = 'VISUAL',
        v = 'VISUAL',
        R = 'REPLACE'
      }
      vim.api.nvim_command('hi GalaxyViMode gui=bold guibg=' .. mode_color())
      local alias_mode = alias[vim.fn.mode()]
      if alias_mode == nil then alias_mode = vim.fn.mode() end
      return '  ' .. alias_mode .. ' '
    end,
    separator = ' ',
    highlight = {colors.bg, colors.bg},
    separator_highlight = {colors.bg, colors.bg}
  }
})

print(vim.fn.getbufvar(0, 'ts'))
vim.fn.getbufvar(0, 'ts')

table.insert(section.left, {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg}
  }
})

table.insert(section.left, {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    separator = ' ',
    separator_highlight = {colors.bg, colors.bg},
    highlight = {mode_color, colors.bg}
  }
})

table.insert(section.left, {
  GitIcon = {
    provider = function()
      return ' '
    end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.orange, colors.bg}
  }
})

table.insert(section.left, {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.grey, colors.bg}
  }
})

table.insert(section.right, {
  DiagnosticError = {provider = 'DiagnosticError', icon = '  ', highlight = {colors.error_red, colors.bg}}
})
table.insert(section.right,
             {DiagnosticWarn = {provider = 'DiagnosticWarn', icon = '  ', highlight = {colors.orange, colors.bg}}})

table.insert(section.right, {
  DiagnosticHint = {provider = 'DiagnosticHint', icon = '  ', highlight = {colors.vivid_blue, colors.bg}}
})

table.insert(section.right, {
  DiagnosticInfo = {provider = 'DiagnosticInfo', icon = '  ', highlight = {colors.info_yellow, colors.bg}}
})

table.insert(section.right, {
  TreesitterIcon = {
    provider = function()
      if next(vim.treesitter.highlighter.active) ~= nil then return '   ' end
      return ''
    end,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.green, colors.bg}
  }
})

table.insert(section.right, {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = check_active_lsp,
    icon = '  ',
    highlight = {colors.grey, colors.bg}
  }
})

table.insert(section.right, {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    condition = condition.buffer_not_empty,
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.fg, colors.bg}
  }
})

table.insert(section.right, {
  LineInfo = {
    provider = 'LineColumn',
    separator = '  ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.grey, colors.bg}
  }
})

table.insert(section.right, {
  Space = {
    provider = function()
      return ' '
    end,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.orange, colors.bg}
  }
})

table.insert(section.right, {
  ScrollBar = {
    provider = 'ScrollBar',
    condition = condition.buffer_not_empty,
    seperator = ' | ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.yellow, colors.bg}
  }
})

table.insert(section.right, {
  Space = {
    provider = function()
      return ' '
    end,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.bg, colors.bg}
  }
})
