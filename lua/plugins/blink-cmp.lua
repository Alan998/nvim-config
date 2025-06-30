return {
	-- autocompletion
	'saghen/blink.cmp',
	event = 'VimEnter',
	version = '1.*',
	dependencies = {
		-- snippet engine
		{
			'L3MON4D3/LuaSnip',
			version = '2.*',
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
					return
				end
				return 'make install_jsregexp'
			end)(),
			dependencies = {
				-- `friendly-snippets` contains a variety of premade snippets.
				--    See the README about individual language/framework/plugin snippets:
				--    https://github.com/rafamadriz/friendly-snippets
				-- {
				--   'rafamadriz/friendly-snippets',
				--   config = function()
				--     require('luasnip.loaders.from_vscode').lazy_load()
				--   end,
				-- },
			},
			opts = {},
		},
		'folke/lazydev.nvim',
	},
	opts = {
		keymap = {
			preset = 'default',
			-- ['<C-e>'] = { 'hide' }, -- use this to close the menu and undo the select
			['<C-s>'] = { 'select_and_accept' },
		},
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'normal',
		},
		completion = {
			-- By default, you may press `<c-space>` to show the documentation.
			-- Optionally, set `auto_show = true` to show the documentation after a delay.
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
			list = {
				selection = { preselect = false, auto_insert = true },
			},
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'lazydev' },
			providers = {
				lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
			},
		},

		snippets = { preset = 'luasnip' },
		-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
		-- which automatically downloads a prebuilt binary when enabled.
		--
		fuzzy = { implementation = 'prefer_rust_with_warning' },
		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },
	},
}

