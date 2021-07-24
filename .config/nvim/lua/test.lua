
local test = {}

function test.get_lsp_caps(client_id)
	local client
	-- local client = vim.lsp.get_active_clients()
	if not client_id then
		local first_client_id = vim.lsp.get_active_clients()[1].id
		client = vim.lsp.get_client_by_id(first_client_id)
	else
		client = vim.lsp.get_client_by_id(tonumber(client_id))
	end

	local lsp_caps = client.resolved_capabilities

	print(client.id)
	-- print(vim.inspect(client))
	print(vim.inspect(lsp_caps))
end
return test
