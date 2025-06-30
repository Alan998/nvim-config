local function augroup(name)
	return vim.api.nvim_create_augroup('my_augroup' .. name, { clear = true })
end

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = augroup('highlight_yank'),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
	group = augroup('resize_splits'),
	callback = function()
		vim.cmd('tabdo wincmd =')
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
	group = augroup('last_loc'),
	callback = function()
		local exclude = { 'gitcommit' }
		local buf = vim.api.nvim_get_current_buf()
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
	group = augroup('close_with_q'),
	pattern = {
		'PlenaryTestPopup',
		'help',
		'lspinfo',
		'man',
		'notify',
		'qf',
		'spectre_panel',
		'startuptime',
		'tsplayground',
		'neotest-output',
		'checkhealth',
		'neotest-summary',
		'neotest-output-panel',
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
	group = augroup('wrap_spell'),
	pattern = { 'gitcommit', 'markdown' },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = augroup('auto_create_dir'),
	callback = function(event)
		if event.match:match('^%w%w+://') then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

-- do not continue comments if O, o, or enter pressed
vim.api.nvim_create_autocmd('BufEnter', {
	group = augroup('comment_format_opt'),
	pattern = '*',
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions
		- 'o' -- O, o pressed, don't continue comments
		- 'r' -- enter pressed, don't continue comments
		--+ 'r' -- enter pressed, But do continue when pressing enter.
	end,
})

-- change vim-matchup highlight colors
vim.api.nvim_create_autocmd('ColorScheme', {
	group = augroup('matchup_matchparen_highlight'),
	pattern = '*',
	desc = 'Change vim-matchup highlight colors',
	callback = function()
		--vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FFEB95', bg = '#8EC07C' })
		vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FBF1C7', bg = '#8EC07C' })
	end,
})
