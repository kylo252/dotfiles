local schemas = require("schemastore").json.schemas()
table.insert(schemas, {
  fileMatch = {
    "vcpkg.json",
  },
  url = "https://raw.githubusercontent.com/microsoft/vcpkg/master/scripts/vcpkg.schema.json",
})
local opts = {
  settings = {
    json = {
      schemas = schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}

return opts
