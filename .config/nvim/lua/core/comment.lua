local M = {}
function M.setup()
  require("kommentary.config").use_extended_mappings()
  require("kommentary.config").configure_language("lua", {
    prefer_single_line_comments = true,
  })
  require("kommentary.config").configure_language("c", {
    prefer_single_line_comments = true,
    single_line_comment_string = "///",
    multi_line_comment_strings = { "/*", "*/" },
  })
end
return M
