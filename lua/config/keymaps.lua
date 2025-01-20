--	mode name
--		'n': Normal mode
--		'i': Insert mode
--		'v': Visual mode
--		'x': Visual block mode
--		'o': Operation pending
--		'c': Command-line mode

-- Better up/down
vim.keymap.set({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })

-- Windows
vim.keymap.set('n', '<leader>ww', '<C-w>p', { desc = 'Move to another window', remap = true })
vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = 'Close current window', remap = true })
vim.keymap.set('n', '<leader>-', '<C-w>p', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-w>p', { desc = 'Split window to the right', remap = true })
-- Keybinds to make split navigation easier.
-- Use <CTRL+hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Use <Alt+hjkl> to move in insert mode
vim.keymap.set('i', '<A-h>', '<left>', { desc = 'Move left in insert mode' })
vim.keymap.set('i', '<A-l>', '<right>', { desc = 'Move right in insert mode' })
vim.keymap.set('i', '<A-j>', '<down>', { desc = 'Move down in insert mode' })
vim.keymap.set('i', '<A-k>', '<up>', { desc = 'Move up in insert mode' })

-- Resize window using <CTRL+arrow keys>
vim.keymap.set('n', '<C-up>',    '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-down>',  '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-left>',  '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move Lines with <Alt+jk>
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move current line down one line' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move current line up one line' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move current selections up one line' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move current selections down one line' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better behavior of n and N when going to the next and previous search result
-- check https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n for more information
vim.keymap.set('n', 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'Next search result' })
vim.keymap.set('x', 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'Next search result' })
vim.keymap.set('o', 'n', '"Nn"[v:searchforward]', { expr = true, desc = 'Next search result' })
vim.keymap.set('n', 'n', '"nN"[v:searchforward]', { expr = true, desc = 'Previous search result' })
vim.keymap.set('x', 'n', '"nN"[v:searchforward]', { expr = true, desc = 'Previous search result' })
vim.keymap.set('o', 'n', '"nN"[v:searchforward]', { expr = true, desc = 'Previous search result' })

-- Better indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Outdent current selections' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent current selections' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Join lines and jump to the original position
vim.keymap.set('n', 'J', 'mzJ`z')

-- Jump half page and keep the line in the middle of the screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Search and keep the line in the middle of the screen
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Toggle Netrw (enable if not using neo-tree)
--vim.keymap.set('n', '<leader>E', ':Lexplore<CR>', { desc = 'Toggle netrw' })

-- Toggle auto complete
local function toggle_auto_complete()
	local cmp = require('cmp')
	local current_setting = cmp.get_config().completion.autocomplete
	if current_setting and #current_setting > 0 then
		cmp.setup({ completion = { autocomplete = false } })
		vim.notify("Disabled auto completion")
	else
		cmp.setup({ completion = { autocomplete = { cmp.TriggerEvent.TextChanged } } })
		vim.notify("Enabled auto completion")
	end
end
vim.api.nvim_create_user_command('CmpToggle', toggle_auto_complete, {})
vim.keymap.set('n', "<leader>tc", "<cmd>CmpToggle<cr>", { desc = "toggle auto complete"})
