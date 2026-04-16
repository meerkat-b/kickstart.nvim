local lang = require 'custom.lang'
local util = require 'custom.lang.util'

lang.register('python', {
  run = function() util.run_in_split('python3 ' .. vim.fn.expand '%') end,
  run_all_tests = function() util.run_in_split 'python3 -m pytest -v -s' end,
  test_file = function() util.run_in_split('python3 -m pytest -v -s ' .. vim.fn.expand '%') end,
  test_cursor = function()
    local name = util.enclosing_function_name { 'function_definition' }
    if not name then
      vim.notify('No function under cursor', vim.log.levels.WARN)
      return
    end
    util.run_in_split('python3 -m pytest -v -s ' .. vim.fn.expand '%' .. ' -k ' .. name)
  end,
  debug_file = function()
    require('dap').run {
      type = 'python',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      console = 'integratedTerminal',
    }
  end,
  debug_test = function() require('dap-python').test_method() end,
})
