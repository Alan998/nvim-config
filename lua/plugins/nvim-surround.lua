return {
	'kylechui/nvim-surround',
	version = '*', -- Use for stability; omit to use `main` branch for the latest features
	event = 'VeryLazy',
	config = true,
	opts = {
		keymaps = {
			-- FIXME: find a way to disable insert mode, default mapping is <C-g>s and <C-g>S which I do not use
			-- insert = '',
			-- insert_line = '',
			normal = '<leader>us',
			normal_cur = '<leader>uS',
			normal_line = '<leader>ul',
			normal_cur_line = '<leader>uL',
			delete = '<leader>ud',
			change = '<leader>uc',
			change_line = '<leader>uC',
			visual = '<leader>us',
			visual_line = '<leader>uS',
		},
		surrounds = {
			['('] = {
				add = { '(', ')' },
			},
			[')'] = {
				add = { '( ', ' )' },
			},
			['{'] = {
				add = { '{', '}' },
			},
			['}'] = {
				add = { '{ ', ' }' },
			},
			['<'] = {
				add = { '<', '>' },
			},
			['>'] = {
				add = { '< ', ' >' },
			},
			['['] = {
				add = { '[', ']' },
			},
			[']'] = {
				add = { '[ ', ' ]' },
			},
		},
	}
}
