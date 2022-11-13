---@diagnostic disable
-- vim: ft=lua tw=80

stds.nvim = {
  globals = {
    "vim",
  },
  read_globals = {
    "jit",
    "os",
    "join_paths",
    "reload",
    "log_entry",
    "dump",
    "P",
  },
}
std = "lua51+nvim"

files["tests/*_spec.lua"].std = "lua51+nvim+busted"
files["lua/scratch*.lua"].ignore = { "212", "211" }

-- Don't report unused self arguments of methods.
self = false

-- Rerun tests only if their modification time changed.
cache = true

ignore = {
  "631", -- max_line_length
  "212/_.*", -- unused argument, for vars with "_" prefix
}
