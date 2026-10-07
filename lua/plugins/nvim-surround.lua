return {
	'kylechui/nvim-surround',
	version = '*',
	event = 'VeryLazy',
	config = function()
		-- Setup behavior
		require("nvim-surround").setup({
			surrounds = {
				['('] = { add = { '(', ')' } },
				[')'] = { add = { '( ', ' )' } },
				['{'] = { add = { '{', '}' } },
				['}'] = { add = { '{ ', ' }' } },
				['<'] = { add = { '<', '>' } },
				['>'] = { add = { '< ', ' >' } },
				['['] = { add = { '[', ']' } },
				[']'] = { add = { '[ ', ' ]' } },
			},
		})

		-- Define keymaps using Plug mappings
		-- Normal mode
		vim.keymap.set("n", "<leader>us", "<Plug>(nvim-surround-add)", { desc = "Surround add" })
		vim.keymap.set("n", "<leader>uS", "<Plug>(nvim-surround-add-cur)", { desc = "Surround add current" })
		vim.keymap.set("n", "<leader>ul", "<Plug>(nvim-surround-add-line)", { desc = "Surround add line" })
		vim.keymap.set("n", "<leader>uL", "<Plug>(nvim-surround-add-cur-line)", { desc = "Surround add current line" })
		vim.keymap.set("n", "<leader>ud", "<Plug>(nvim-surround-delete)", { desc = "Surround delete" })
		vim.keymap.set("n", "<leader>uc", "<Plug>(nvim-surround-change)", { desc = "Surround change" })
		vim.keymap.set("n", "<leader>uC", "<Plug>(nvim-surround-change-line)", { desc = "Surround change line" })

		-- Visual mode
		vim.keymap.set("x", "<leader>us", "<Plug>(nvim-surround-visual)", { desc = "Surround visual" })
		vim.keymap.set("x", "<leader>uS", "<Plug>(nvim-surround-visual-line)", { desc = "Surround visual line" })
	end
}
