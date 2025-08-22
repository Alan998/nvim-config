-- function to filter whitespace so neoclip does not store pure whitespace yanks
local function is_whitespace(line)
	return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
	for _, entry in ipairs(tbl) do
		if not check(entry) then
			return false
		end
	end
	return true
end

return {
	'AckslD/nvim-neoclip.lua',
	lazy = true,
	--event = 'VimEnter',
	dependencies = {
		{'nvim-telescope/telescope.nvim'},
		--{'kkharji/sqlite.lua'},
		{'ibhagwan/fzf-lua'},
	},
	keys = {
		{ '<leader>fy',
			function()
				require('telescope').extensions.neoclip.default()
			end,
			desc = 'Find history yanks (neoclip)' },
		--{ '<leader>tC', function() require('neoclip').toggle() end, desc = 'Toggle neoclip' },
	},
	opts = {
		history = 64,
		filter = function (data)
			return not all(data.event.regcontents, is_whitespace)
		end,
	},
	config = function()
		require('neoclip').setup()
	end,
}
