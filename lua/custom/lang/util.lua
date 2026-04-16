local M = {}

function M.enclosing_function_name(node_types)
  local node = vim.treesitter.get_node()
  local type_set = {}
  for _, t in ipairs(node_types) do
    type_set[t] = true
  end

  while node do
    if type_set[node:type()] then
      local name_node = node:field('name')[1]
      if name_node then return vim.treesitter.get_node_text(name_node, 0) end
    end
    node = node:parent()
  end
  return nil
end

function M.run_in_split(cmd) vim.cmd('split | terminal ' .. cmd) end

return M
