-- FIXME: switch to telescope-undo.nvim in the future
return {
	'jiaoshijie/undotree',
	dependencies = 'nvim-lua/plenary.nvim',
	config = true,
	keys = { -- load the plugin only when using it's keybinding:
		{ '<leader>tu', function() require('undotree').toggle() end, desc = 'Toggle undotree' },
	},
	opts = {
		window = {
			winblend = 20, -- value between 0-100, 0 for fully opaque and 100 for fully transparent
		},
	},
}
