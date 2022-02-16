local M = {}

function M.setup()
  local i = require("neogen.types.template").item
  local custom_template = {
    -- { nil, "/// ", { no_results = true, type = { "func", "file", "class" } } },
    { nil, "/// @file", { no_results = true, type = { "file" } } },
    { nil, "/// @brief $1", { no_results = true, type = { "func", "file", "class" } } },
    -- { nil, "/// ", { no_results = true, type = { "func", "file", "class" } } },
    { nil, "", { no_results = true, type = { "file" } } },

    -- { nil, "/// ", { type = { "func", "class" } } },
    { i.ClassName, "/// @class %s", { type = { "class" } } },
    { nil, "/// @brief $1", { type = { "func", "class" } } },
    -- { nil, "/// ", { type = { "func", "class" } } },
    { i.Tparam, "/// @tparam %s $1" },
    { i.Parameter, "/// @param %s $1" },
    { i.Return, "/// @return $1" },
    -- { nil, "/// ", { type = { "func", "class" } } },
  }

  require("neogen").setup {
    enable = true,
    input_after_command = true,
    languages = {
      c = {
        template = {
          annotation_convention = "my_annotation",
          my_annotation = custom_template,
        },
      },
    },
  }
end

return M
