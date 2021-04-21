require'nvim-treesitter.configs'.setup {
 ensure_installed = { "cpp", "c", "bash", "lua", "yaml", "regex", "json", "jsonc", "go", "rust", "ruby", "toml"}, 
 -- O.treesitter.ensure_installed, -- one of "all", "maintained" (parsers with maintainers), or a list  of languages
 -- ignore_install = { "haskell", "comment", "typescript", "elm", "rst", "javascript", "svelte", "scala",  "jsdoc", "glimmer" },
 highlight = {
     enable = O.treesitter.highlight.enabled -- false will disable the whole extension
 },
  -- indent = {enable = true, disable = {"python", "html", "javascript"}},
  indent = {enable = true},
  autotag = {enable = true},
}
