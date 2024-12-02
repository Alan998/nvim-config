-- A fancy, configurable, notification manager for NeoVim
return {
	'rcarriga/nvim-notify',
	lazy = false,
	--event = 'VeryLazy',
	keys = {
		{ '<leader>nt', function(opts) require('telescope').extensions.notify.notify(opts) end, desc = 'search [N]otifications in [T]elescope'},
		{ '<leader>nh', function()  require('notify').history() end, desc = 'display [N]otification [H]istory'},
	},
	opts = {
		render = 'compact',
		stages = 'static',
		topdown = false,
		timeout = 60 * 1000, -- milliseconds (false to disable timeout)
	},
	-- uncomment this to test and see how notification looks
	--init = function () require('notify')('test notify message') end
}
