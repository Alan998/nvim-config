vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
-- speed-up startup time
vim.g.loaded_python3_provider = 0
vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog = "/usr/sbin/python3"
vim.opt.pyxversion = 3

-- separate vim plugins from neovim in case vim is still in use
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

-- some tweaks to make netrw better
-- Keep the current directory and the browsing directory synced.
-- This helps to avoid the move files error.
vim.g.netrw_keepdir = 0
-- split size (in percentage) of the Netrw window
vim.g.netrw_winsize = 15
-- Hide the banner. To show it temporarily can use I inside Netrw.
vim.g.netrw_banner = 0
-- Change the copy command. Mostly to enable recursive copy of directories.
vim.g.netrw_localcopydircmd = 'cp -r'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--[[
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)
--]]

if vim.fn.has('wsl') == 1 then
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

vim.opt.background = 'dark' -- Set background colors (dark/light)
vim.termguicolors = true -- True color support
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.lazyredraw = true -- Redraw the screen less during tasks
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- Use relative line numbers
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history, undo dir is located at ~/.local/share/nvim/undo
vim.opt.undolevels = 128

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 500
vim.opt.timeoutlen = 200 -- Decrease mapped sequence wait time

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live as you type
-- vim.opt.inccommand = 'split'
vim.opt.inccommand = 'nosplit'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4
vim.opt.shiftround = true -- Round indent to multiple of shiftwidth
vim.opt.shiftwidth = 4
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.whichwrap = '<,>,[,]'
vim.opt.wrap = false -- Disable line wrap

