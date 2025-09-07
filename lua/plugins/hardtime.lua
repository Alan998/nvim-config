-- Establish good command workflow and quit bad habit
-- NOTE: Clean logs regularly ( logs are located in ~/.local/state/nvim/log )
return {
	'm4xshen/hardtime.nvim',
	--enabled = false,
	event = 'VeryLazy',
	-- add nvim-notify to dependencies to show log messages using nvim-notify
	dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify' },
	cmd = { 'Hardtime' },
	keys = {
		{ '<leader>tH', '<cmd>Hardtime toggle<CR>', desc = 'Toggle Hardtime'},
	},
	opts = {
		-- enabling scrolling up and down
		disabled_keys = {
			--['<Up>'] = {},
			--['<Down>'] = {},
		},
		-- maximum count of repeated key presses allowed
		max_count = 5,
		disable_mouse = false,
		-- disable for .log, .txt files
		-- use command :set filetype? to check the filetype
		disabled_filetypes = {
			'NvimTree',
			'TelescopePrompt',
			'aerial',
			'alpha',
			'checkhealth',
			'dapui*',
			'Diffview*',
			'Dressing*',
			'help',
			'httpResult',
			'lazy',
			'lspinfo',
			'Neogit*',
			'mason',
			'neotest%-summary',
			'minifiles',
			'neo%-tree*',
			'netrw',
			'noice',
			'notify',
			'prompt',
			'qf',
			'query',
			'oil',
			'undotree',
			'trouble',
			'Trouble',
			'fugitive',
			'',
			'text',
		},
		callback = function(text)
			-- default callback
			vim.notify(text, vim.log.levels.WARN, { title = 'hardtime' })

			-- nvim-notify callback
			--vim.notify = require('notify')
			--vim.notify(text, vim.log.levels.WARN, { title = 'hardtime' })
		end,
	},
}
