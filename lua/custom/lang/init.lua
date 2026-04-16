local M = {}
local handlers = {}

function M.register(filetype, tbl) handlers[filetype] = tbl end

-- Publish the module before loading language files so their top-level
-- `require('custom.lang')` resolves without re-entering this chunk.
package.loaded['custom.lang'] = M

local function dispatch(verb)
  return function()
    local ft = vim.bo.filetype
    local h = handlers[ft]
    if not h or not h[verb] then
      vim.notify(('No %s for %s'):format(verb, ft == '' and '<no filetype>' or ft), vim.log.levels.WARN)
      return
    end
    h[verb]()
  end
end

vim.keymap.set('n', '<leader>rr', dispatch 'run', { desc = 'Run file' })
vim.keymap.set('n', '<leader>ra', dispatch 'run_all_tests', { desc = 'Run all tests' })
vim.keymap.set('n', '<leader>rf', dispatch 'test_file', { desc = 'Run tests in file' })
vim.keymap.set('n', '<leader>rt', dispatch 'test_cursor', { desc = 'Run test under cursor' })
vim.keymap.set('n', '<leader>dd', dispatch 'debug_file', { desc = 'Debug file' })
vim.keymap.set('n', '<leader>dt', dispatch 'debug_test', { desc = 'Debug test under cursor' })

for _, ft in ipairs { 'go', 'python', 'rust' } do
  require('custom.lang.' .. ft)
end

return M
