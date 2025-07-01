--[[ 
--  setup the chosen color scheme:
--      ...
--      config = funcion()
--          require('colorscheme_name').setup{
	--              --  ... color_scheme_config_options ...
	--          }
	--          vim.cmd[[colorscheme colorscheme_name]]
--      end
--]]

return {
	{
		'folke/tokyonight.nvim',
		enabled = false,
		lazy = true,
		priority = 1000,
		opts = {
			style = 'storm',
			styles = {
				keywords = { italic = false },
			},
			-- change some hilight groups
			on_highlights = function(hl, c)
				hl.MatchParen = {
					bg = c.orange,
					fg = c.bg_dark,
				}
			end,
		},
		init = function() vim.cmd.colorscheme('tokyonight') end,
	},
	{
		'ellisonleao/gruvbox.nvim',
		--enabled = false,
		lazy = true,
		priority = 1000,
		terminal_colors = true,
		opts = {
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = true,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = 'hard', -- can be 'hard', 'soft' or empty string
			-- change highlight of group Substitute so plugin flash's labels have different colors
			-- overrides = { Substitute = { fg = '#1d2021', bg = '#ebdbb2' } },
			overrides = { Substitute = { fg = '#1d2021', bg = '#d3869b' }, debugPC = { link = 'DiffAdd' }, },
			dim_inactive = true,
			transparent_mode = true,
		},
		init = function() vim.cmd.colorscheme('gruvbox') end,
	},
}
