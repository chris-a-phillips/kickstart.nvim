-- Shmml Svaqre (svyrf, yfc, rgp)
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      theme = 'center',
      sorting_strategy = 'ascending',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.3,
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- goto keymaps
    vim.keymap.set('n', '<leader>pd', function()
      require('goto-preview').goto_preview_definition()
    end, { desc = '[P]review [D]efinition', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>pt', function()
      require('goto-preview').goto_preview_type_definition()
    end, { desc = '[P]review [T]ype Definition', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>pi', function()
      require('goto-preview').goto_preview_implementation()
    end, { desc = '[P]review [I]mplementation', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>pD', function()
      require('goto-preview').goto_preview_declaration()
    end, { desc = '[P]review [D]eclaration', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>pP', function()
      require('goto-preview').close_all_win()
    end, { desc = '[P]review [P]review Close All Windows', noremap = true, silent = true })
    vim.keymap.set('n', '<leader>pr', function()
      require('goto-preview').goto_preview_references()
    end, { desc = '[P]review [R]eferences', noremap = true, silent = true })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    -- Custom keymappings

    -- Key mappings for basic Git commands

    -- Key mappings for basic Git commands
    vim.keymap.set('n', '<leader>ga', function()
      vim.cmd('G add ' .. vim.fn.expand '%')
    end, { desc = '[G]it [A]dd current file' })

    vim.keymap.set('n', '<leader>gc', function()
      vim.cmd 'G commit'
    end, { desc = '[G]it [C]ommit' })

    vim.keymap.set('n', '<leader>gd', function()
      vim.cmd 'G diff'
    end, { desc = '[G]it [D]iff' })

    vim.keymap.set('n', '<leader>gs', function()
      vim.cmd 'G status'
    end, { desc = '[G]it [S]tatus' })

    vim.keymap.set('n', '<leader>gl', function()
      vim.cmd 'G log'
    end, { desc = '[G]it [L]og' })

    vim.keymap.set('n', '<leader>gp', function()
      vim.cmd 'G push'
    end, { desc = '[G]it [P]ush' })

    vim.keymap.set('n', '<leader>gu', function()
      vim.cmd 'G pull'
    end, { desc = '[G]it p[U]ll' })

    vim.keymap.set('n', '<leader>gco', function()
      vim.cmd 'G checkout'
    end, { desc = '[G]it [C]heck[O]ut' })

    vim.keymap.set('n', '<leader>gx', function()
      vim.cmd 'G branch'
    end, { desc = '[G]it branch' })

    -- Key mappings for advanced Git commands
    vim.keymap.set('n', '<leader>grb', function()
      vim.cmd 'G fetch origin && G rebase origin/master'
    end, { desc = '[G]it [R]ebase onto origin/master' })

    vim.keymap.set('n', '<leader>gcrb', function()
      vim.cmd 'G fetch origin && G checkout --track origin/'
    end, { desc = '[G]it [C]heckout [R]emote [B]ranch' })

    vim.keymap.set('n', '<leader>gsc', function()
      vim.cmd 'G stash clear'
    end, { desc = '[G]it [S]tash [C]lear' })

    vim.keymap.set('n', '<leader>gsh', function()
      vim.cmd 'G show'
    end, { desc = '[G]it [S]how' })

    vim.keymap.set('n', '<leader>guc', function()
      vim.cmd 'G reset HEAD~1 --mixed'
    end, { desc = '[G]it [U]ndo last [C]ommit' })

    vim.keymap.set('n', '<leader>gac', function()
      vim.cmd 'G commit --amend -m'
    end, { desc = '[G]it [A]mend [C]ommit' })

    vim.keymap.set('n', '<leader>gus', function()
      vim.cmd 'G restore --staged'
    end, { desc = '[G]it [U]nstage [S]taged' })

    vim.keymap.set('n', '<leader>gpc', function()
      vim.cmd 'G push origin HEAD'
    end, { desc = '[G]it [P]ush [C]urrent branch' })

    vim.keymap.set('n', '<leader>gre', function()
      if vim.fn.system 'git rev-parse --verify --quiet main' ~= '' then
        vim.cmd 'G diff main...HEAD'
      elseif vim.fn.system 'git rev-parse --verify --quiet master' ~= '' then
        vim.cmd 'G diff master...HEAD'
      else
        print 'Error: Main or master branch not found'
      end
    end, { desc = '[G]it [Re]view changes in branch from main/master' })

    vim.keymap.set('n', '<leader>grh', function()
      vim.cmd 'G reset --hard'
    end, { desc = '[G]it [R]eset [H]ard' })

    vim.keymap.set('n', '<leader>gdb', function()
      vim.cmd 'G branch -D'
    end, { desc = '[G]it [D]elete [B]ranch' })

    vim.keymap.set('n', '<leader>gbf', function()
      vim.cmd "G branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
    end, { desc = '[G]it [B]ranch with [F]ormatting' })

    vim.keymap.set('n', '<leader>grf', function()
      vim.cmd "G branch -r --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
    end, { desc = '[G]it [R]emote branch with [F]ormatting' })

    vim.keymap.set('n', '<leader>gf', function()
      vim.cmd 'G fetch'
    end, { desc = '[G]it [F]etch' })

    vim.keymap.set('n', '<leader>gpo', function()
      vim.cmd "G push -u 2>&1 | tee >(cat) | grep 'pull/new' | awk '{print $2}' | xargs open"
    end, { desc = '[G]it [P]ush and open pull request' })

    vim.keymap.set('n', '<leader>gcb', function()
      vim.cmd "G branch | grep * | cut -d ' ' -f2"
    end, { desc = '[G]it [C]urrent [B]ranch name' })

    vim.keymap.set('n', '<leader>gl1', function()
      vim.cmd "G log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
    end, { desc = '[G]it [L]og format 1' })

    vim.keymap.set('n', '<leader>gl2', function()
      vim.cmd "G log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
    end, { desc = '[G]it [L]og format 2' })

    vim.keymap.set('n', '<leader>gl3', function()
      vim.cmd "G log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n          %C(white)%s%C(reset)%n          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
    end, { desc = '[G]it [L]og format 3' })
    -- End of custom commands
  end,
}
