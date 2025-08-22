return {
	-- open a terminal
	'akinsho/toggleterm.nvim',
	lazy = true,
	--event = 'VeryLazy',
	cmd = { 'ToggleTerm' },
	opts = {
		open_mapping = [[<c-\>]],
		direction = 'vertical',
		size = 80,
		shade_terminals = false,
	},
	keys = {
		{ "<C-\\>", '<cmd>ToggleTerm<cr>', desc = 'toggle a terminal' },
		-- Move in and out of the terminal
		{ '<C-h>', mode = { 't' }, '<Cmd>wincmd h<CR>' },
		{ '<C-j>', mode = { 't' }, '<Cmd>wincmd j<CR>' },
		{ '<C-k>', mode = { 't' }, '<Cmd>wincmd k<CR>' },
		{ '<C-l>', mode = { 't' }, '<Cmd>wincmd l<CR>' },
		{ '<Esc>', mode = { 't' }, "<C-\\><C-n>", desc = 'switch to normal mode'},
	},
}
