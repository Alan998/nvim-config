-- Show variables, functions, class etc. on the sidebar
return {
	'hedyhli/outline.nvim',
	lazy = true,
	cmd = { 'Outline', 'OutlineOpen' },
	keys = {
		{ '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
	},
	opts = {
		show_relative_numbers = true,
		icons = {
			Key = { icon = ' ', hl = 'Type' },
		}
	},
}
