-- Highlight todo, notes, etc in comments
return {
	'folke/todo-comments.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	event = 'VimEnter',
	cmd = { 'TodoTrouble', 'TodoTelescope' },
	keys = {
		{ ']t', function() require('todo-comments').jump_next() end, desc = 'Next TODO comment' },
		{ '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous TODO comment' },
		{ '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'TODO (Trouble)' },
		{ '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = 'TODO/FIX/FIXME (Trouble)' },
		{ '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'TODO' },
		{ '<leader>fT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'TODO/FIX/FIXME' },
	},
	config = true,
}
