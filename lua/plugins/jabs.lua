-- Buffer switcher
return {
	'matbme/JABS.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	keys = { {'<leader>j', '<cmd>JABSOpen<cr>', desc = 'Preview/Switch buffer'}},
	opts = {
		sort_mru = true, -- sort buffer by most recently used
		enabled = true,
		symbols = {
			current = '  ',
			--current = '  ',
			split = '  ',
			alternate = ' 󱀲 ',
			hidden = '  ',
			locked = ' 󰌾 ',
			ro = ' 󰈈 ',
			edited = '  ',
			--edited = '  ',
			terminal = '  ',
			default_file = '  ',
			--terminal_symbol = '  '
		},
	},
	cmd = { 'JABSOpen' },
	--config = true,
}
