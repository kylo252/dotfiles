---@diagnostic disable: lowercase-global, undefined-global
-- luacheck: ignore 111 113

-- LuaRocks configuration

-- IMPORTANT: this requires luarocks to also be built with the following config
--- `./configure --prefix=$HOME/.local --sysconfdir=$HOME/.config`

rocks_trees = {
   { name = "system", root = "/usr/local" };
   { name = "user", root = home .. "/.local" };
}

-- home_tree = home .. "/.local"

lua_interpreter = "luajit"
cmake_generator = "Ninja"
local_by_default = false

variables = {
   LUA_INCDIR = "/usr/include/luajit-2.1";
   LUA_BINDIR = "/bin";
}

