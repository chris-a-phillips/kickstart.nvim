-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains using the new which-key spec
    require('which-key').register {
      { '<leader>c', group = '[C]ode' },
      { '<leader>c_', hidden = true }, -- Ignore this key
      { '<leader>d', group = '[D]ocument' },
      { '<leader>d_', hidden = true }, -- Ignore this key
      { '<leader>r', group = '[R]ename' },
      { '<leader>r_', hidden = true }, -- Ignore this key
      { '<leader>s', group = '[S]earch' },
      { '<leader>s_', hidden = true }, -- Ignore this key
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>w_', hidden = true }, -- Ignore this key
      { '<leader>;', group = '[;]Arrow Buffer' },
      { '<leader>;_', hidden = true }, -- Ignore this key
      { "<leader>'", group = "[']Arrow File" }, -- Fixed typo here
      { "<leader>'_", hidden = true }, -- Ignore this key
      { '<leader>u', group = '[U]ndo Tree' },
      { '<leader>u_', hidden = true }, -- Ignore this key
      { '<leader>e', group = '[E]File Explorer' },
      { '<leader>e_', hidden = true }, -- Ignore this key
      { '<leader>g', group = '[G] Git' },
      { '<leader>g_', hidden = true }, -- Ignore this key
      { '<leader>p', group = '[P]review' },
      { '<leader>p_', hidden = true }, -- Ignore this key
    }
  end,
}
