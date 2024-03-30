-- plugins/init.lua

-- List of plugins with short URLs
local plugins = {
    "folke/neodev.nvim", -- 
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    { 'numToStr/Comment.nvim', opts = {} },

    'ThePrimeagen/vim-be-good', -- practice for vim motions

}

-- Importeed plugins with configurations
table.insert(plugins, require("plugins.solarized-osaka")) -- colorscheme solarized-osaka
table.insert(plugins, require("plugins.gitsigns"))
table.insert(plugins, require("plugins.which-key"))
table.insert(plugins, require("plugins.telescope"))

return plugins