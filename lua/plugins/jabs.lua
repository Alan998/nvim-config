-- Buffer switcher
return {
	'matbme/JABS.nvim',
	keys = { {'<leader>J', '<cmd>JABSOpen<cr>', desc = 'Preview/Switch buffer'}},
	opts = {
		sort_mru = true, -- sort buffer by most recently used
		enabled = true,
	},
	cmd = { 'JABSOpen' },
	--config = true,
}
