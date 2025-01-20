-- Highlight todo, notes, etc in comments
return {
	'folke/todo-comments.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	event = 'VeryLazy',
	cmd = { 'TodoTrouble', 'TodoTelescope' },
	keys = {
		{ ']t', function() require('todo-comments').jump_next() end, desc = 'Next Todo Comment' },
		{ '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous Todo Comment' },
		{ '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
		{ '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
		{ '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
		{ '<leader>fT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
	},
	config = true,
}
