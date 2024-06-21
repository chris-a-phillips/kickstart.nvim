return {
  'supermaven-inc/supermaven-nvim',
  version = '*', -- or specify a version string, e.g., "1.0.0"
  lazy = false, -- Set to true if you want to load the plugin lazily
  config = function()
    require('supermaven-nvim').setup {}
  end,
}
