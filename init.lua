-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Set neovim options, keymaps, and auto commands ]]
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.rustceanvim'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- NOTE: Clean logs regularly ( logs are located in ~/.local/state/nvim/log )
