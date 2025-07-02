return {
	'mrcjkb/rustaceanvim',
	version = '^6', -- Recommended
	lazy = false, -- This plugin is already lazy
	opts = {
		server = {
			on_attach = function(client, bufnr)
				-- you can also put keymaps in here
			end,
			default_settings = {
				-- rust-analyzer language server configuration
				['rust-analyzer'] = {
					checkOnType = true,
				},
			},
		},
	}
}
