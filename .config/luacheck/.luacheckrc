---@diagnostic disable: lowercase-global, undefined-global

stds.nvim = {
  read_globals = { "jit" }
}

std = "lua51+nvim"

-- Don't report unused self arguments of methods.
self = false

-- Rerun tests only if their modification time changed.
cache = true

ignore = {
  "631",  -- max_line_length
  "212/_.*",  -- unused argument, for vars with "_" prefix
}

-- The unit tests can use busted
files["spec"].std = "+busted"
files["*_spec"].std = "+busted"

-- Global objects defined by the C code
globals = {
  "vim",
}

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
