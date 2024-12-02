-- Resizes split windows automatically 
return {
	'nvim-focus/focus.nvim', version = '*',
	--event = 'WinEnter',
	event = 'VeryLazy',
	cmd = { 'FocusEnable', 'FocusToggle', 'FocusDisable', 'FocusSplitNicely' },
	keys = {
		{ '<leader>e', function() require('focus').focus_equalise() end, desc = 'equalises the splits' },
		{ '<leader>tf', function() require('focus').focus_toggle() end, desc = 'toggle focus plugin' },
	},
	opts = {
		autoresize = {
			height_quickfix = 5,
		},
	},
	config = function ()
		require('focus').setup()
		local ignore_filetypes = { 'neo-tree', 'trouble' }
		local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

		local augroup =
		vim.api.nvim_create_augroup('FocusDisable', { clear = true })

		vim.api.nvim_create_autocmd('WinEnter', {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
				then
					vim.w.focus_disable = true
				else
					vim.w.focus_disable = false
				end
			end,
			desc = 'Disable focus autoresize for BufType',
		})

		vim.api.nvim_create_autocmd('FileType', {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
					vim.b.focus_disable = true
				else
					vim.b.focus_disable = false
				end
			end,
			desc = 'Disable focus autoresize for FileType',
		})
	end,
}
