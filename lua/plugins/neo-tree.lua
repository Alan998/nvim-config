return {
	'nvim-neo-tree/neo-tree.nvim',
	--event = 'VimEnter',
	branch = 'v3.x',
	cmd = { 'Neotree' },
	dependencies = {
		'nvim-lua/plenary.nvim',
		--'nvim-tree/nvim-web-devicons',
		'echasnovski/mini.pairs',
		'MunifTanjim/nui.nvim',
		-- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	opts = {
		filesystem = {
			follow_current_file = { enabled = true },
		},
		window = {
			width = 32,
			mappings = {
				-- open file
				['f'] = 'system_open',
			},
		},
		commands = {
			-- open files in another terminal
			system_open = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				-- Linux: open file in default application
				vim.fn.jobstart({ 'xdg-open', path }, { detach = true })
				--vim.fn.jobstart({'kitty', '--', 'nvim', '--noswapfile', path }, { detach = true })

				-- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
				local p
				local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
				if lastSlashIndex then
					p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
				else
					p = path -- If no slash found, return original path
				end
				vim.cmd('silent !start explorer ' .. p)
			end,
		},
		event_handlers = {
			--[[
			{
				-- Auto Close on Open File
				event = 'file_open_requested',
				handler = function()
					require('neo-tree.command').execute({ action = 'close' })
				end
			},
			--]]

		},
		default_component_configs = {
			diagnostics = {
				symbols = {
					error = ' ',
					hint  = '󰌵',
					info  = ' ',
					warn  = ' ',
				},
				highlights = {
					hint = 'DiagnosticSignHint',
					info = 'DiagnosticSignInfo',
					warn = 'DiagnosticSignWarn',
					error = 'DiagnosticSignError',
				},
			},
		},
	},
	keys = {
		{ '<space>E', '<cmd>Neotree toggle<cr>', desc = 'Toggle neo-tree' },
	},
	init = function()
		-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
		-- because `cwd` is not set up properly.
		vim.api.nvim_create_autocmd('BufEnter', {
			group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
			desc = 'Start Neo-tree with directory',
			once = true,
			callback = function()
				if package.loaded['neo-tree'] then
					return
				else
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == 'directory' then
						require('neo-tree')
					end
				end
			end,
		})
	end,
}
