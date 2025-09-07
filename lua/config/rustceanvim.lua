vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {},
	-- LSP configuration
	server = {
		--on_attach = function(client, bufnr)
			-- put keymaps in here
		--end,
			default_settings = {
				-- rust-analyzer language server configuration
				['rust-analyzer'] = {
					checkOnType = true,
					checkOnSave = false,
				},
			},
	},
	-- DAP configuration
	dap = {},
}
