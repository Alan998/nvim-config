-- Status bar
-- color table for icons
local colors = {
	yellow   = '#fabd2f',
	green    = '#b8bb26',
	orange   = '#fe8019',
	violet   = '#d3869b',
	blue     = '#83a598',
	red      = '#fb4934',
}

return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		--{ 'nvim-tree/nvim-web-devicons', lazy = true },
		{ 'echasnovski/mini.icons', version = '*' },
	},
	event = 'VeryLazy',
	opts = function()
		return {
			options = {
				theme = 'powerline',
				component_separators = { left = '|', right = '|' },
				disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
			},
			sections = {
				--lualine_a = { { 'mode', icon = ' ' } },
				lualine_a = { { 'mode', icon = ' ' } },
				lualine_b = {
					{ 'branch' },
					{
						require('lazy.status').updates,
						cond = require('lazy.status').has_updates,
					},
					{
						'diff',
						symbols = {
							added = ' ',
							modified = ' ',
							removed = ' ',
						},
					},
				},
				lualine_c = {
					{
						'diagnostics',
						symbols = {
							error = ' ',
							--error = ' ',
							warn = ' ',
							hint = '󰌵 ',
							info = ' ',
						},
						diagnostics_color = {
							error = {fg = colors.red},
							warn  = {fg = colors.yellow},
							info  = {fg = colors.blue},
							hint  = {fg = colors.green},
						},
					},
				},
				lualine_x = {
					{ 'filetype', icon_only = true, separator = '', padding = { right = 0 } },
					{
						'filename',
						path = 0,
						symbols = { modified = ' ', readonly = '󱧉 ' },
					},
				},
				lualine_y = {},
				lualine_z = { 'location' },
			},
			--extensions = { 'neo-tree', 'lazy', 'quickfix' },
		}
	end,
	config = true,
}
