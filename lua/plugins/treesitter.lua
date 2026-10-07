return {
	{ -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup({
				install_dir = vim.fn.stdpath('data') .. '/site',
				highlight = { enable = true },
				indent = { enable = true },
			})
			require('nvim-treesitter').install({
				'c', 'cpp', 'go', 'lua', 'luadoc', 'python', 'rust',
				'bash', 'markdown', 'markdown_inline',
			})
		end,
	},
}
