-- debugger setup in neovim

-- function copied from LazyVim
---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
	local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
	local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str))
		if config.type and config.type == 'java' then
			---@diagnostic disable-next-line: return-type-mismatch
			return new_args
		end
		return vim.split(new_args, ' ')
	end
	return config
end

return {
	{
		'mfussenegger/nvim-dap',
		--enabled = false,
		dependencies = {
			-- Creates a beautiful debugger UI
			'rcarriga/nvim-dap-ui',

			-- Installs the debug adapters for you
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',

			-- Adds virtual text support to nvim-dap
			'theHamsta/nvim-dap-virtual-text',

			-- Add your own debuggers here
			--'leoluz/nvim-dap-go',
		},
		keys = {
			{ '<leader>d', '', desc = '+debug', mode = {'n'} },
			{ '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
			{ '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
			{ '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
			--{ '<leader>da', function() require('dap').continue({ before = get_args }) end, desc = 'Run with Args' },
			{ '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
			{ '<leader>dg', function() require('dap').goto_() end, desc = 'Go to Line (No Execute)' },
			{ '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
			{ '<leader>dj', function() require('dap').down() end, desc = 'Down' },
			{ '<leader>dk', function() require('dap').up() end, desc = 'Up' },
			{ '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
			{ '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },
			{ '<leader>dO', function() require('dap').step_over() end, desc = 'Step Over' },
			{ '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
			{ '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
			{ '<leader>ds', function() require('dap').session() end, desc = 'Session' },
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			{ '<F7>', function() require('dapui').toggle() end, desc = 'Debug: See last session result.' },
			{ '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
			{ '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
		},
		config = function()
			-- Change breakpoint icons
			vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
			vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
			local breakpoint_icons = vim.g.have_nerd_font
			and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '⊘', LogPoint = '', Stopped = '󰁕 ' }
			for type, icon in pairs(breakpoint_icons) do
				local tp = 'Dap' .. type
				local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
				vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
			end

			-- Install golang specific config
			--[[
			require('dap-go').setup {
				delve = {
					-- On Windows delve must be run attached or it crashes.
					-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
					detached = vim.fn.has 'win32' == 0,
				},
			},
			--]]
		end,
	},
	-- fancy UI for the debugger
	{
		'rcarriga/nvim-dap-ui',
		dependencies = { 'nvim-neotest/nvim-nio' },
		-- stylua: ignore
		keys = {
			{ '<leader>du', function() require('dapui').toggle({ }) end, desc = 'Dap UI' },
			{ '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = {'n', 'v'} },
		},
		opts = {

			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				icons = {
					pause = '󰏤 ',
					play = ' ',
					step_into = ' ',
					step_over = ' ',
					step_out = ' ',
					step_back = ' ',
					run_last = ' ',
					terminate = ' ',
					disconnect = ' ',
				},
			},

		},
		config = function()
			require('dapui').setup()
			local dap = require('dap')
			local dapui = require('dapui')
			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close
		end,
	},
	-- mason.nvim integration
	{
		'jay-babu/mason-nvim-dap.nvim',
		dependencies = 'mason.nvim',
		cmd = { 'DapInstall', 'DapUninstall' },
		opts = {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = false,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- Check that you have the required things installed online
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				--delve, -- go debugger
			},
		},
		-- mason-nvim-dap is loaded when nvim-dap loads
		config = true,
	},
	{
		'theHamsta/nvim-dap-virtual-text',
		enabled =false,
		config = true,
	},
}
