return {
	'andymass/vim-matchup',
	enabled = false,
	event = 'BufReadPost',
	keys = {
		{ '<leader>%', '<Plug>(matchup-[%)', desc = 'Go to parent bracket' }
	},
	opts = {
		matchup_matchparen_stopline = 1024,
	},
}
