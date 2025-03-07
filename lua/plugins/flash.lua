-- Flash enhances the built-in search functionality by showing labels
-- at the end of each match, letting you quickly jump to a specific
-- location.
return {
	'folke/flash.nvim',
	event = 'VeryLazy',
	---@type Flash.Config
	opts = {
		--label = { rainbow = { enabled = true }, },
		modes = {
			-- search enabled by default, can be toggled by <c-s>
			search = { enabled = false },
			char = { 
				multi_line = true,
				jump_labels = true,
				-- When using jump labels, don't use these keys
				-- This allows using those keys directly after the motion
				label = { exclude = "hjkliardcpxyDPY" },
			},
		},
	},
	-- stylua: ignore
	keys = {
		{
			's',
			mode = { 'n', 'x' },
			function() require('flash').jump() end,
			desc = 'Flash'
		},
		{
			's',
			mode = 'o', -- mode such as when y is already pressed
			function() require('flash').remote() end,
			desc = 'Remote Flash'
		},
		{
			'S',
			mode = { 'n', 'o', 'x' },
			function() require('flash').treesitter() end,
			desc = 'Flash Treesitter'
		},
		{
			'R',
			mode = { 'o', 'x' },
			function() require('flash').treesitter_search() end,
			desc = 'Treesitter Search'
		},
		{
			-- toggle in search mode
			'<c-s>',
			mode = { 'c' },
			function() require('flash').toggle() end,
			desc = 'Toggle Flash Search'
		},
	},
}
