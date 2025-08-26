return {
	{
		-- Diff viewer and merge tool
		'sindrets/diffview.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
		keys = {
			{ '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open diff view' },
			{ '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'Close diff view' },
			{ '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Open file history' },
			{ '<leader>gb', '<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>', desc = 'Review branch changes' },
			{
				"<leader>gD",
				function()
					vim.ui.input({ prompt = "Commit rev or path: (leave blank for current)" }, function(target)
						if not target then
							return
						end
						if target == "" then
							vim.cmd("DiffviewOpen")
						else
							vim.cmd("DiffviewOpen " .. target)
						end
					end)
				end,
				desc = "Diff View",
			},
			{
				"<leader>gF",
				function()
					vim.ui.input(
						{ prompt = "Commit rev or path: (leave blank for current branch)", completion = "file" },
						function(target)
							if not target then
								return
							end
							if target == "" then
								vim.cmd("DiffviewFileHistory")
							else
								vim.cmd("DiffviewFileHistory " .. target)
							end
						end
					)
				end,
				desc = "Diff View file history",
			},
		},
		opts = {
			enhanced_diff_hl = true,
			use_icons = true,
			view = {
				default = { layout = 'diff2_horizontal' },
				merge_tool = {
					layout = 'diff4_mixed',
					disable_diagnostics = true,
				},
			},
		},
	},
}
