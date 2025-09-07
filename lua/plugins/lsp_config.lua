-- LSP Plugins
-- Brief aside: **What is LSP?**
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a 'server' which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some 'client' - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`
return {
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		'mason-org/mason.nvim',
		cmd = 'Mason',
		build = ':MasonUpdate',
		opts = {
			ensure_installed = {
				'stylua',
			},
			ui = {
				border = 'rounded',
				icons = {
					package_installed = ' ',
					package_pending = ' ',
					package_uninstalled = ' ',
				},
			},
		},
	},
	{
		-- Main LSP Configuration
		'neovim/nvim-lspconfig',
		event = 'BufReadPre',
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- Mason must be loaded before its dependents so we need to set it up here
			{ 'mason-org/mason.nvim', config = true, },
			'mason-org/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim',

			-- Allows extra capabilities provided by 
			'saghen/blink.cmp',
		},
		cmd = 'LspStart',
		keys = {
			{ '<leader>td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, desc = 'Toggle Lsp diagnostics' },
			{ '<leader>dl',
				function()
					local toggle_config = not vim.diagnostic.config().virtual_lines
					vim.diagnostic.config({ virtual_lines = toggle_config })
				end,
				desc = 'Toggle diagnostic virtual_lines'},
			{ 'gh', vim.lsp.buf.hover, desc = 'Hover Lsp information' },
			{'<leader>dh', function() vim.diagnostic.open_float() end, desc = 'Diagnostic hover window'},
			{'<leader>dt', function() require('telescope.builtin').diagnostics() end, desc = 'Telescope diagnostic'},
		},
		config = function()
			--  This function gets run when an LSP attaches to a particular buffer.
			--  That is to say, every time a new file is opened that is associated with
			--  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--  function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or 'n'
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map('gd', require('telescope.builtin').lsp_definitions, 'Goto definition')

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map('gD', vim.lsp.buf.declaration, 'Goto declaration')

					-- Find references for the word under your cursor.
					--map('gr', require('telescope.builtin').lsp_references, '')

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map('gi', require('telescope.builtin').lsp_implementations, 'Goto implementation')

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map('gt', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')

					-- Fuzzy find all the symbols in the current buffer(document).
					--  Symbols are things like variables, functions, types, etc.
					map('<leader>fs', require('telescope.builtin').lsp_document_symbols, 'Find symbols')

					-- Fuzzy find all the symbols in the current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map('<leader>fS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Find workspace symbols')

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					-- map('<leader>cr', vim.lsp.buf.rename, 'Rename variable under cursor')

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					-- map('<leader>ca', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })


					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					--[[
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
						vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd('LspDetach', {
							group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
							end,
						})
					end
					--]]

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					-- Enable/Disable inlay hint
					vim.lsp.inlay_hint.enable(false)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						map('<leader>th', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
						end, 'Toggle inlay hints')
					end

					-- Set icons for Diagnostics
					local diagnostic_icons = {
						Error = ' ',
						--Error = ' ',
						Warn = ' ',
						Hint = '󰌵 ',
						Info = ' ',
					}

					-- Diagnostics options
					local diagnostics_opts = {
						signs = {
							text = {
								[vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
								[vim.diagnostic.severity.WARN ] = diagnostic_icons.Warn,
								[vim.diagnostic.severity.HINT ] = diagnostic_icons.Hint,
								[vim.diagnostic.severity.INFO ] = diagnostic_icons.Info,
							},
						},
						underline = true,
						update_in_insert = false,
						virtual_text = {
							spacing = 4,
							source = 'if_many',
							--prefix ='',
							--prefix = '󰧞',
							--prefix = '',
							prefix = '󰨓',
							-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
							-- this only works on a recent 0.10.0 build. Will be set to '●' when not supported
							-- prefix = 'icons',
						},
						--virtual_text = false,
						virtual_lines = false,
						severity_sort = true,
					}
					vim.diagnostic.config(vim.deepcopy(diagnostics_opts))

					-- config Telescope diagnostic icons
					for type, icon in pairs(diagnostic_icons) do
						local hl = 'DiagnosticSign' .. type
						vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
					end

				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- c/cpp
				clangd = {
					cmd = { 'clangd', '--clang-tidy', '--background-index', '--cross-file-rename' },
					filetypes = { 'h', 'c', 'hpp', 'cpp', 'cc' },
					settings = {
						enable_inlay_hints = true,
						fallbackFlags = { '-std=c++20', '-Wall', '-Wextra' },
					},
				},
				-- pyright = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace',
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},

				-- golang
				gopls = {
					filetypes = { 'go', 'gomod', 'gosum' },
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},

				--[[
				-- zig
				zls = {
					cmd = { 'zls' },
					filetypes = { 'zig' },
					settings = {
						enable_inlay_hints = true,
						enable_argument_placeholders = false,
						--completion_label_details = false,
					},
				},
				--]]
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require('mason').setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				'stylua', -- Used to format Lua code
			})
			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			require('mason-lspconfig').setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						require('lspconfig')[server_name].setup(server)
					end,
				},
			}
		end,
	},
}
