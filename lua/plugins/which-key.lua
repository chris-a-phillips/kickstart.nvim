-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains using the new spec
    local wk = require 'which-key'
    wk.add {
      { "<leader>'", group = "[']Arrow File', _ = 'which_key_ignore" },
      { '<leader>*', group = '[*] Git' },
      { '<leader>*_', hidden = true },
      { '<leader>;', group = '[;]Arrow Buffer' },
      { '<leader>;_', hidden = true },
      { '<leader>c', group = '[C]ode' },
      { '<leader>c_', hidden = true },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>d_', hidden = true },
      { '<leader>e', group = '[E]File Explorer' },
      { '<leader>e_', hidden = true },
      { '<leader>p', group = '[P]review' },
      { '<leader>p_', hidden = true },
      { '<leader>r', group = '[R]ename' },
      { '<leader>r_', hidden = true },
      { '<leader>s', group = '[S]earch' },
      { '<leader>s_', hidden = true },
      { '<leader>u', group = '[U]ndo Tree' },
      { '<leader>u_', hidden = true },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>w_', hidden = true },
    }
  end,
}
