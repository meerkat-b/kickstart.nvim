local lang = require 'custom.lang'
local util = require 'custom.lang.util'

lang.register('rust', {
  run = function() util.run_in_split 'cargo run' end,
  run_all_tests = function() util.run_in_split 'cargo test -- --nocapture' end,
  test_cursor = function()
    local name = util.enclosing_function_name { 'function_item' }
    if not name then
      vim.notify('No function under cursor', vim.log.levels.WARN)
      return
    end
    util.run_in_split('cargo test ' .. name .. ' -- --nocapture')
  end,
})
