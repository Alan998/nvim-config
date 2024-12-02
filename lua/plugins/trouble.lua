-- better diagnostics list
return {
	'folke/trouble.nvim',
	cmd = { 'Trouble' },
	opts = {
		auto_preview = false,
		win = { type = 'split' },
		focus = true,
		preview = {
			--type = 'main',
			type = 'float',
			border = 'rounded',
			-- `position` and `size` goes with type split, delete these 2 options if other types are used
			-- type = 'split', position = 'right', size = 0.6,
		},
		modes = {
			lsp = {
				win = {
					type = 'float',
				},
			},
			symbols = { -- Configure symbols mode
				win = {
					type = 'split',
					relative = 'win', -- relative to current window
					position = 'right',
					size = 0.5, -- 50% of the window size
				},
			},
		},
	},
	keys = {
		{ '<leader>xX', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
		{ '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
		{ '<leader>xs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
		{ '<leader>xS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
		{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
		{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
		{
			'[q',
			function()
				if require('trouble').is_open() then
					require('trouble').prev({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cprev)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = 'Previous Trouble/Quickfix Item',
		},
		{
			']q',
			function()
				if require('trouble').is_open() then
					require('trouble').next({ skip_groups = true, jump = true })
				else
					local ok, err = pcall(vim.cmd.cnext)
					if not ok then
						vim.notify(err, vim.log.levels.ERROR)
					end
				end
			end,
			desc = 'Next Trouble/Quickfix Item',
		},
	},
	config = true,
}
