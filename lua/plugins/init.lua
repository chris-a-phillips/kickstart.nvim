-- plugins/init.lua

-- -- List of plugins with short URLs
-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

-- NOTE: Plugins can also be added by using a table,
-- with the first argument being the link and the following
-- keys can be used to configure plugin behavior/loading/etc.
--
-- Use `opts = {}` to force a plugin to be loaded.
--
--  This is equivalent to:
--    require('Comment').setup({})
-- 'gc' to comment visual regions/lines
local plugins = {
  { 'folke/neoconf.nvim', opts = {} , cmd = 'Neoconf' },
  { 'folke/neodev.nvim', opts = {} },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'folke/todo-comments.nvim', opts = {} , event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } }, -- Highlight todo, notes, etc in comments
  { 'ThePrimeagen/vim-be-good'}, -- practice for vim motions
  { 'tpope/vim-fugitive'},
}

-- -- Importeed plugins with configurations
-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
table.insert(plugins, require 'plugins.autoformat')
table.insert(plugins, require 'plugins.colorschemes') -- colorscheme solarized-osaka
table.insert(plugins, require 'plugins.conform')
table.insert(plugins, require 'plugins.gitsigns')
table.insert(plugins, require 'plugins.nvim-cmp')
table.insert(plugins, require 'plugins.nvim-lspconfig')
table.insert(plugins, require 'plugins.nvim-tree')
table.insert(plugins, require 'plugins.telescope')
table.insert(plugins, require 'plugins.treesitter')
table.insert(plugins, require 'plugins.undotree')
table.insert(plugins, require 'plugins.which-key')

return plugins
