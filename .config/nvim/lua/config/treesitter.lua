-- avoid problems with old `gcc` on RHEL7
require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

require 'nvim-treesitter.configs'.setup {
 -- ensure_installed = { "cpp", "c", "bash", "lua", "yaml", "regex", "json", "jsonc", "go", "rust", "ruby", "toml"}, 
 --ensure_installed = { "all" }, 
 -- O.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list  of languages
 ignore_install = {},
 highlight = {
     enable = O.treesitter.highlight.enabled -- false will disable the whole extension
 },
  -- indent = {enable = true, disable = {"python", "html", "javascript"}},
  indent = {enable = true},
  autotag = {enable = true},
}
