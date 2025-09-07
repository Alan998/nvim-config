-- Resizes split windows automatically 
return {
	'nvim-focus/focus.nvim', version = '*',
	event = 'VeryLazy',
	cmd = { 'FocusEnable', 'FocusToggle', 'FocusDisable', 'FocusSplitNicely' },
	keys = {
		{ '<leader>wa', function() require('focus').focus_autoresize() end, desc = 'auto resize windows' },
		{ '<leader>we', function() require('focus').focus_equalise() end, desc = 'equalises window splits' },
		{ '<leader>wm', function() require('focus').focus_maximise() end, desc = 'maximise current window' },
		{ '<leader>tf', function() require('focus').focus_toggle() end, desc = 'toggle focus plugin' },
	},
	opts = {
		autoresize = {
			height_quickfix = 8,
		},
	},
	config = function ()
		require('focus').setup()
		local ignore_filetypes = { 'neo-tree', 'trouble', 'DiffviewFiles' }
		local ignore_buftypes = { 'nofile', 'popup', 'prompt' }

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
