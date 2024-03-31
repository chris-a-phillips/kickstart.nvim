local M = {}

M.setup = function()
  -- -- Autocommands

  -- Disable the concealing in some file formats
  -- The default conceallevel is 3 in LazyVim
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'json', 'jsonc' },
    callback = function()
      vim.wo.conceallevel = 0
    end,
  })

  -- Automatically change directory to buffer's directory
  vim.cmd [[
  autocmd BufEnter * execute 'cd ' .. fnamemodify(expand('%:p:h'), ':p')
]]

  vim.cmd [[
    autocmd BufEnter * KeysToggle
]]

  -- -- Automatically show bufferline when opening a new tab
  -- vim.cmd([[
  --   autocmd TabNewEntered * lua require('bufferline').open()
  -- ]])
end

return M
