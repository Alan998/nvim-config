return {
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		--event = 'VimEnter',
		event = 'VeryLazy',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
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
				desc = 'Switch Buffer',
			},
			{ '<leader>:', '<cmd>Telescope command_history<CR>', desc = 'Command History' },
			-- git
			{ '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'Commits' },
			{ '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'Status' },
			{ '<leader>gf', '<cmd>Telescope git_files<CR>', desc = 'Find git-files' },
			-- find
			--{ '<leader>fr', '<cmd>Telescope oldfiles<CR>', desc = '[F]ind Recent Files ('.' for repeat)' },
			{ "<leader>f'", '<cmd>Telescope registers<CR>', desc = 'Registers' },
			{ '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Buffer' },
			{ '<leader>fc', '<cmd>Telescope command_history<CR>', desc = 'Command History' },
			--{ '<leader>fC', '<cmd>Telescope commands<CR>', desc = 'Commands' },
			{ '<leader>fd', '<cmd>Telescope diagnostics bufnr=0<CR>', desc = '[F]ind [D]iagnostics' },
			{ '<leader>fD', '<cmd>Telescope diagnostics<CR>', desc = '[F]ind Workspace [D]iagnostics' },
			{ '<leader>ff', '<cmd>Telescope find_files<CR>', desc = '[F]ind [F]iles' },
			{ '<leader>fF', '<cmd>Telescope find_files search_dirs=~<CR>', desc = ' [F]iles from home_dir' },
			{ '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = '[F]ind by [G]rep' },
			{ '<leader>fG',
				function()
					local home_dir = os.getenv('HOME')
					vim.cmd('Telescope live_grep search_dirs=' .. home_dir)
				end,
				desc = '[F]ind by [G]rep from home dir'
			},
			{
				'<leader>fh',
				function ()
					require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!**/.git/*' }})
				end,
				desc = '[F]ind [H]idden files'
			},
			--{ '<leader>fhi', '<cmd>Telescope highlights<CR>', desc = '[F]ind [H]ighlight Groups' },
			{ '<leader>fH', '<cmd>Telescope help_tags<CR>', desc = '[F]ind [H]elp Pages' },
			{ '<leader>fj', '<cmd>Telescope jumplist<CR>', desc = '[F]ind [J]umplist' },
			{ '<leader>fk', '<cmd>Telescope keymaps<CR>',  desc = '[F]ind [K]eymaps' },
			{ '<leader>fl', '<cmd>Telescope loclist<CR>', desc = '[F]ind Location List' },
			{ '<leader>fM', '<cmd>Telescope man_pages<CR>', desc = '[F]ind Man Pages' },
			{ '<leader>fm', '<cmd>Telescope marks<CR>', desc = '[F]ind Jump to Mark' },
			--{ '<leader>fo', '<cmd>Telescope vim_options<CR>', desc = '[F]ind Options' },
			{ '<leader>fr', '<cmd>Telescope resume<CR>', desc = '[F]ind [R]esume' },
			{ '<leader>fq', '<cmd>Telescope quickfix<CR>', desc = '[F]ind [Q]uickfix List' },
			{ '<leader>fs', '<cmd>Telescope builtin<CR>', desc = '[F]ind [S]elect Telescope' },
			{ '<leader>fw', '<cmd>Telescope grep_string<CR>', desc = '[F]ind current [W]ord' },
			{ '<leader>f.', '<cmd>Telescope oldfiles<CR>', desc = '[F]ind Recent Files ("." for repeat)' },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require('telescope').setup {
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				defaults = {
					prompt_prefix = ' ',
					selection_caret = ' ',
					layout_strategy = 'flex',
					mappings = {
						i = {
							['<C-v>'] = require('telescope.actions.layout').toggle_preview,
							['<C-Down>'] = require('telescope.actions').cycle_history_next,
							['<C-Up>'] = require('telescope.actions').cycle_history_prev,
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

			-- See `:help telescope.builtin`
			local builtin = require 'telescope.builtin'

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set('n', '<leader>/', function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end, { desc = '[/] Fuzzily find in current buffer' })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set('n', '<leader>f/', function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				}
			end, { desc = '[F]ind [/] in Open Files' })

			-- Shortcut for finding your Neovim configuration files
			vim.keymap.set('n', '<leader>fn', function()
				builtin.find_files { cwd = vim.fn.stdpath 'config' }
			end, { desc = '[F]ind [N]eovim files' })
		end,
	},
	{
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<leader>b', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>', desc = 'Open Telescope file browser at the path of the current buffer' },
			{ '<leader>B', '<cmd>Telescope file_browser path=~ select_buffer=true<CR>', desc = 'Open Telescope file browser at the path of home' },
		},
	},
}
