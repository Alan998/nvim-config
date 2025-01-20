return {
	'gennaro-tedesco/nvim-possession',
	dependencies = {
		'ibhagwan/fzf-lua',
	},
	opts = {
		fzf_winopts = {
			-- any valid fzf-lua winopts options, for instance
			width = 0.5,
			preview = {
				vertical = "right:30%"
			}
		}
	},
	keys = {
		{'<leader>sl', function() require("nvim-possession").list() end, desc='list sessions' },
		{'<leader>sn', function() require("nvim-possession").new() end, desc='new sessions' },
		{'<leader>su', function() require("nvim-possession").update() end, desc='update sessions' },
		{'<leader>sd', function() require("nvim-possession").delete() end, desc='delete sessions' },
	},
}
