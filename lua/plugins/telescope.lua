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
    vim.keymap.set('n', '<leader>*a', function()
      vim.cmd('G add ' .. vim.fn.expand '%')
    end, { desc = '[*] Git [A]dd current file' })
    vim.keymap.set('n', '<leader>*C', function()
      vim.cmd 'G commit'
    end, { desc = '[*] Git [C]ommit' })
    vim.keymap.set('n', '<leader>*d', function()
      vim.cmd 'G diff'
    end, { desc = '[*] Git [D]iff' })
    vim.keymap.set('n', '<leader>*s', function()
      vim.cmd 'G status'
    end, { desc = '[*] Git [S]tatus' })
    vim.keymap.set('n', '<leader>*l', function()
      vim.cmd 'G log'
    end, { desc = '[*] Git [L]og' })
    vim.keymap.set('n', '<leader>*p', function()
      vim.cmd 'G push'
    end, { desc = '[*] Git [P]ush' })
    vim.keymap.set('n', '<leader>*u', function()
      vim.cmd 'G pull'
    end, { desc = '[*] Git p[U]ll' })
    vim.keymap.set('n', '<leader>*co', function()
      vim.cmd 'G checkout'
    end, { desc = '[*] Git [C]heck[O]ut' })
    vim.keymap.set('n', '<leader>*x', function()
      vim.cmd 'G branch'
    end, { desc = '[*] Git branch' })

    -- Key mappings for advanced Git commands
    vim.keymap.set('n', '<leader>**rb', function()
      vim.cmd 'G fetch origin && G rebase origin/master'
    end, { desc = '[**] Git [R]ebase onto origin/master' })
    vim.keymap.set('n', '<leader>**crb', function()
      vim.cmd 'G fetch origin && G checkout --track origin/'
    end, { desc = '[**] Git [C]heckout [R]emote [B]ranch' })
    vim.keymap.set('n', '<leader>**sc', function()
      vim.cmd 'G stash clear'
    end, { desc = '[**] Git [S]tash [C]lear' })
    vim.keymap.set('n', '<leader>**sh', function()
      vim.cmd 'G show'
    end, { desc = '[**] Git [S]how' })
    vim.keymap.set('n', '<leader>**uc', function()
      vim.cmd 'G reset HEAD~1 --mixed'
    end, { desc = '[**] Git [U]ndo last [C]ommit' })
    vim.keymap.set('n', '<leader>**ac', function()
      vim.cmd 'G commit --amend -m'
    end, { desc = '[**] Git [A]mend [C]ommit' })
    vim.keymap.set('n', '<leader>**us', function()
      vim.cmd 'G restore --staged'
    end, { desc = '[**] Git [U]nstage [S]taged' })
    vim.keymap.set('n', '<leader>**pc', function()
      vim.cmd 'G push origin HEAD'
    end, { desc = '[**] Git [P]ush [C]urrent branch' })
    vim.keymap.set('n', '<leader>**re', function()
      if vim.fn.system 'git rev-parse --verify --quiet main' ~= '' then
        vim.cmd 'G diff main...HEAD'
      elseif vim.fn.system 'git rev-parse --verify --quiet master' ~= '' then
        vim.cmd 'G diff master...HEAD'
      else
        print 'Error: Main or master branch not found'
      end
    end, { desc = '[**] Git [Re]view changes in branch from main/master' })
    vim.keymap.set('n', '<leader>**rh', function()
      vim.cmd 'G reset --hard'
    end, { desc = '[**] Git [R]eset [H]ard' })
    vim.keymap.set('n', '<leader>**db', function()
      vim.cmd 'G branch -D'
    end, { desc = '[**] Git [D]elete [B]ranch' })
    vim.keymap.set('n', '<leader>**bf', function()
      vim.cmd "G branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
    end, { desc = '[**] Git [B]ranch with [F]ormatting' })
    vim.keymap.set('n', '<leader>**rf', function()
      vim.cmd "G branch -r --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
    end, { desc = '[**] Git [R]emote branch with [F]ormatting' })
    vim.keymap.set('n', '<leader>**f', function()
      vim.cmd 'G fetch'
    end, { desc = '[**] Git [F]etch' })
    vim.keymap.set('n', '<leader>**po', function()
      vim.cmd "G push -u 2>&1 | tee >(cat) | grep 'pull/new' | awk '{print $2}' | xargs open"
    end, { desc = '[**] Git [P]ush and open pull request' })
    vim.keymap.set('n', '<leader>**cb', function()
      vim.cmd "G branch | grep * | cut -d ' ' -f2"
    end, { desc = '[**] Git [C]urrent [B]ranch name' })
    vim.keymap.set('n', '<leader>**l1', function()
      vim.cmd "G log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"
    end, { desc = '[**] Git [L]og format 1' })
    vim.keymap.set('n', '<leader>**l2', function()
      vim.cmd "G log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
    end, { desc = '[**] Git [L]og format 2' })
    vim.keymap.set('n', '<leader>**l3', function()
      vim.cmd "G log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n          %C(white)%s%C(reset)%n          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
    end, { desc = '[**] Git [L]og format 3' })

    -- End of custom commands
  end,
}
