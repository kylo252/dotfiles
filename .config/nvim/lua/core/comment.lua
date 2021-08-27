local M = {}
function M.setup()
  require("kommentary.config").use_extended_mappings()
  require("kommentary.config").configure_language("lua", {
    prefer_single_line_comments = true,
  })
end
return M
