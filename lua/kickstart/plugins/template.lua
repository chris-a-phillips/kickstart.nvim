-- plugin template:

-- Define your plugin configuration
return {
  -- Specify the plugin name or repository URL
  'author/plugin',

  -- Optional: Specify the version constraint for the plugin
  version = '*', -- or specify a version string, e.g., "1.0.0"

  -- Optional: Set lazy loading to true or false
  lazy = false, -- Set to true if you want to load the plugin lazily

  -- Optional: Define dependencies required by the plugin
  dependencies = {
    'author/dependency1',
    'author/dependency2',
    -- Add more dependencies as needed
  },

  -- Optional: Define configuration for the plugin
  config = function()
    -- Call the setup function of the plugin and pass any configuration options
    require('plugin_name').setup {
      -- Specify configuration options here
      option1 = true,
      option2 = 'value',
      -- Add more options as needed
    }
  end,
}

