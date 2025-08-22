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
			Class = { icon = ' ', hl = 'Type' },
			Enum = { icon = ' ', hl = 'Type' },
			Variable = { icon = ' ', hl = 'Constant' },
			Constant = { icon = ' ', hl = 'Constant' },
			String = { icon = '󰅳 ', hl = 'String' },
			Key = { icon = '󰷖 ', hl = 'Type' },
			Struct = { icon = ' ', hl = 'Structure' },
		}
	},
}
