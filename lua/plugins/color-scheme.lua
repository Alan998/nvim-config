return {
	{
		'folke/tokyonight.nvim',
		enabled = true,
		lazy = true,
		priority = 1000,
		opts = {
			style = 'storm',
			transparent = true,
			styles = {
				keywords = { italic = false },
			},
			-- change some highlight groups
			on_highlights = function(hl, c)
				hl.MatchParen = {
					bg = c.orange,
					fg = c.bg_dark,
				}

				-- Jump Labels
				hl.FlashLabel = {
					bg = "#ffe964", fg = "#1f2335", bold = true
				}
				hl.FlashCurrent = {
					bg = "#73daca", fg = "#1f2335", bold = true
				}
				hl.FlashMatch = {
					bg = "#1abc9c", fg = "#1f2335", bold = true
				}
			end,
		},
		init = function() vim.cmd.colorscheme('tokyonight') end,
	},
	{
		'ellisonleao/gruvbox.nvim',
		enabled = false,
		lazy = true,
		priority = 1000,
		terminal_colors = true,
		opts = {
			undercurl = true,
			underline = true,
			bold = false,
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
			overrides = {
				-- Flash
				Substitute = { fg = '#1d2021', bg = '#d3869b' },

				--LspReferenceText = { bg = '#504945' }

				-- Diffview
				-- DiffviewDiffAddAsDelete = { bg = '#431313' },
				-- DiffviewDiffDelete = { bg = 'none', fg = '#3c3836' },
				-- DiffDelete = {bg = "#37222c"},
				-- DiffAdd = {bg = "#20303b"},
				-- DiffChange = {bg = "#1f2231"},
				-- DiffText = {bg = "#394b70"},
			},
			dim_inactive = true,
			transparent_mode = true,
		},
		init = function() vim.cmd.colorscheme('gruvbox') end,
	},
}
