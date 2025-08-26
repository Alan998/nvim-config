-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a 'file finder', it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use Telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of `help_tags` options and
-- a corresponding preview of the help.
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker.

return {
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				-- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = 'make',

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			--{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
			{ 'echasnovski/mini.icons', version = '*', enabled = vim.g._have_nerd_font },
		},
		cmd = 'Telescope',
		keys = {
			{
				'<leader>,',
				'<cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>',
				desc = 'Switch buffer',
			},
			-- find
			{ "<leader>f'", '<cmd>Telescope registers<CR>', desc = 'Find registers' },
			{ '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Fuzzily find in current buffer' },
			{ '<leader>fc', '<cmd>Telescope command_history<CR>', desc = 'Find command history' },
			{ '<leader>fd', '<cmd>Telescope diagnostics bufnr=0<CR>', desc = 'Find diagnostics' },
			{ '<leader>fD', '<cmd>Telescope diagnostics<CR>', desc = 'Find workspace diagnostics' },
			{ '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
			{ '<leader>fF',
				function()
					-- prompt the user for a directory path
					local dir = vim.fn.input('Enter directory to search in: ', '', 'dir')

					-- exit without doing anything if the user left the input empty
					if dir == '' then return end

					require('telescope.builtin').find_files({ search_dirs = { dir } })
				end,
				desc = 'Find files from input dir',
			},
			{ '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Find by grep' },
			{ '<leader>fG',
				function()
					-- prompt the user for a directory path
					local dir = vim.fn.input('Enter directory to search in: ', '', 'dir')

					-- exit without doing anything if the user left the input empty
					if dir == '' then return end

					require('telescope.builtin').live_grep({search_dirs = { dir }})
				end,
				desc = 'Find by grep from input dir',
			},
			{ '<leader>fj', '<cmd>Telescope jumplist<CR>', desc = 'Find jumplist' },
			{ '<leader>fk', '<cmd>Telescope keymaps<CR>',  desc = 'Find keymaps' },
			{ '<leader>fl', '<cmd>Telescope loclist<CR>', desc = 'Find location list' },
			{ '<leader>fm', '<cmd>Telescope marks<CR>', desc = 'Find marks' },
			{ '<leader>fo', '<cmd>Telescope oldfiles<CR>', desc = 'Find recent files' },
			{ '<leader>fr', '<cmd>Telescope resume<CR>', desc = 'Resume recent search' },
			{ '<leader>fw', '<cmd>Telescope grep_string<CR>', desc = 'Find current word' },
		},
		config = function()
			require('telescope').setup {
				defaults = {
					prompt_prefix = ' ',
					selection_caret = ' ',
					layout_strategy = 'flex',
					initial_mode = 'normal',
					mappings = {
						i = {
							['<C-v>'] = require('telescope.actions.layout').toggle_preview,
							['<C-n>'] = require('telescope.actions').cycle_history_next,
							['<C-p>'] = require('telescope.actions').cycle_history_prev,
							['<C-f>'] = require('telescope.actions').preview_scrolling_down,
							['<C-b>'] = require('telescope.actions').preview_scrolling_up,
						},
						n = {
							['q'] = require('telescope.actions').close,
						},
					},
				},
				-- pickers to also search for hidden files
				--[[
				pickers = {
					find_files = {
						-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
						find_command = { rg', '--files', '--hidden', '--glob', '!**/.git/*' },
					},
				},
				--]]
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
			}
			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')
		end,
	},
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<leader>b', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>', desc = 'open Telescope file_browser in current buffer' },
			--{ '<leader>B', '<cmd>Telescope file_browser path=~ select_buffer=true<CR>', desc = 'Open Telescope file browser at the path of home' },
		},
	},
	{
		'debugloop/telescope-undo.nvim',
		dependencies = {
			{
				'nvim-telescope/telescope.nvim',
				dependencies = { 'nvim-lua/plenary.nvim' },
			},
		},
		keys = {
			{
				'<leader>U',
				'<cmd>Telescope undo<cr>',
				desc = 'undo history',
			},
		},
		opts = {
			-- don't use `defaults = { }` here, do this in the main telescope spec
			extensions = {
				undo = {
					-- telescope-undo.nvim config
				},
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
			-- configs for us. We won't use data, as everything is in it's own namespace (telescope
			-- defaults, as well as each extension).
			require('telescope').setup(opts)
			require('telescope').load_extension('undo')
		end,
	},
}
