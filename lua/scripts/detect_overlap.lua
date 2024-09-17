-- Custom function to detect overlapping keymaps
local function detect_overlapping_keymaps()
  local keymap_types = { 'n', 'v', 'i', 'x', 'o', 't', 's' }
  local mappings = {}
  local overlaps = {}

  for _, mode in ipairs(keymap_types) do
    local map = vim.api.nvim_get_keymap(mode)
    for _, v in ipairs(map) do
      if mappings[v.lhs] then
        table.insert(overlaps, {
          mode = mode,
          key = v.lhs,
          cmd1 = mappings[v.lhs].rhs,
          cmd2 = v.rhs,
        })
      else
        mappings[v.lhs] = { mode = mode, rhs = v.rhs }
      end
    end
  end

  if #overlaps == 0 then
    print 'No overlapping keymaps detected!'
  else
    print 'Overlapping keymaps found:'
    for _, overlap in ipairs(overlaps) do
      print(string.format('Mode: %s | Key: %s | Command 1: %s | Command 2: %s', overlap.mode, overlap.key, overlap.cmd1, overlap.cmd2))
    end
  end
end

-- Call the function to check for overlapping keymaps
detect_overlapping_keymaps()
