return {
	'andymass/vim-matchup',
	--lazy = true,
	event = 'BufReadPost',
	opts = {
		matchup_matchparen_stopline = 512,
	},
}
