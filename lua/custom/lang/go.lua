local lang = require 'custom.lang'
local util = require 'custom.lang.util'

lang.register('go', {
  run = function() util.run_in_split 'go run .' end,
  run_all_tests = function() util.run_in_split 'go test -v ./...' end,
  test_cursor = function()
    local name = util.enclosing_function_name { 'function_declaration' }
    if not name then
      vim.notify('No function under cursor', vim.log.levels.WARN)
      return
    end
    if not name:match '^Test' then return end
    util.run_in_split('go test -run ' .. name .. ' -v ./')
  end,
  debug_test = function() require('dap-go').debug_test() end,
})
