return {
	'saecki/live-rename.nvim',
	lazy = true,
	keys = {
		{ '<leader>R',
			function()
				require("live-rename").rename({text = "", insert = true})
			end,
			desc = 'Rename variable under cursor'
		},
	},
}
