-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>;'] = { name = '[;]Arrow Buffer', _ = 'which_key_ignore' },
      ["<leader>'"] = { name = "[']Arrow File', _ = 'which_key_ignore" },
      ['<leader>u'] = { name = '[U]ndo Tree', _ = 'which_key_ignore' },
      ['<leader>e'] = { name = '[E]File Explorer', _ = 'which_key_ignore' },
      ['<leader>*'] = { name = '[*] Git', _ = 'which_key_ignore' },
    }
  end,
}
