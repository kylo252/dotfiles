-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{
	cmd = {DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server", "--stdio"},
    on_attach = require'lsp'.common_on_attach,
	settings = {
		yaml = {
			scheme = {
				['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.yml'
			}
		}
	}
}
