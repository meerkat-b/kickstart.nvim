--vim.opt.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'
--
----------- FOR TESTING --------------
vim.keymap.set('n', '<leader>zzzzz', ':help', { desc = 'Open help menu' })
--------------------------------------
--
vim.o.wrap = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.o.switchbuf = 'useopen'

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99 -- start with all folds open

-- Handle resizing editor buffers on window resized
vim.api.nvim_create_autocmd('VimResized', {
  callback = function() vim.cmd 'wincmd =' end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function() vim.cmd 'windo set wrap' end,
})

-- Kill all processes when quitting neovim
vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local job_id = vim.b[buf].terminal_job_id
      if job_id then pcall(vim.fn.jobstop, job_id) end
    end
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  callback = function(event)
    local job_id = vim.b[event.buf].terminal_job_id
    if job_id then pcall(vim.fn.jobstop, job_id) end
  end,
})

--
--  KEYMAPS START
--
vim.keymap.set(
  { 'x', 'o' },
  'am',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end,
  { desc = 'Select around function' }
)
vim.keymap.set(
  { 'x', 'o' },
  'im',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end,
  { desc = 'Select in function' }
)
vim.keymap.set(
  { 'x', 'o' },
  'aa',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects') end,
  { desc = 'Select around parameter' }
)
vim.keymap.set(
  { 'x', 'o' },
  'ia',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects') end,
  { desc = 'Select in parameter' }
)
vim.keymap.set(
  { 'x', 'o' },
  'ac',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
  { desc = 'Select around class' }
)
vim.keymap.set(
  { 'x', 'o' },
  'ic',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
  { desc = 'Select in class' }
)

vim.keymap.set('n', '<leader>a', function() require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner' end, { desc = 'Swap parameter with next' })
vim.keymap.set(
  'n',
  '<leader>A',
  function() require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.inner' end,
  { desc = 'Swap parameter with previous' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  ']m',
  function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end,
  { desc = 'Next function start' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  ']]',
  function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end,
  { desc = 'Next class start' }
)
-- You can also pass a list to group multiple queries.
vim.keymap.set(
  { 'n', 'x', 'o' },
  ']o',
  function() require('nvim-treesitter-textobjects.move').goto_next_end({ '@loop.inner', '@loop.outer' }, 'textobjects') end,
  { desc = 'Next loop end' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  '[o',
  function() require('nvim-treesitter-textobjects.move').goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects') end,
  { desc = 'Previous loop start' }
)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
vim.keymap.set(
  { 'n', 'x', 'o' },
  ']s',
  function() require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals') end,
  { desc = 'Next scope' }
)
vim.keymap.set({ 'n', 'x', 'o' }, ']z', function() require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds') end, { desc = 'Next fold' })

vim.keymap.set(
  { 'n', 'x', 'o' },
  ']M',
  function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects') end,
  { desc = 'Next function end' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  '][',
  function() require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects') end,
  { desc = 'Next class end' }
)

vim.keymap.set(
  { 'n', 'x', 'o' },
  '[m',
  function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end,
  { desc = 'Previous function start' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  '[[',
  function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end,
  { desc = 'Previous class start' }
)

vim.keymap.set(
  { 'n', 'x', 'o' },
  '[M',
  function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects') end,
  { desc = 'Previous function end' }
)
vim.keymap.set(
  { 'n', 'x', 'o' },
  '[]',
  function() require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects') end,
  { desc = 'Previous class end' }
)

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree<CR>', { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader>x', function()
  local job_id = vim.b.terminal_job_id
  if job_id then vim.fn.jobstop(job_id) end
  vim.cmd 'close!'
end, { desc = 'Close current window and kill process' })

local ts_selection_stack = {}

vim.keymap.set('n', '<CR>', function()
  local node = vim.treesitter.get_node()
  if not node then return end
  ts_selection_stack = { node }
  local sr, sc, er, ec = node:range()
  vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
  vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
  vim.cmd 'normal! gv'
end, { desc = 'Start treesitter selection' })

vim.keymap.set('x', '<CR>', function()
  if #ts_selection_stack == 0 then return end
  local current = ts_selection_stack[#ts_selection_stack]
  local parent = current:parent()
  if not parent then return end
  table.insert(ts_selection_stack, parent)
  local sr, sc, er, ec = parent:range()
  vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
  vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
  vim.cmd 'normal! gv'
end, { desc = 'Expand treesitter selection' })

vim.keymap.set('x', '<BS>', function()
  if #ts_selection_stack <= 1 then return end
  table.remove(ts_selection_stack)
  local node = ts_selection_stack[#ts_selection_stack]
  local sr, sc, er, ec = node:range()
  vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
  vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
  vim.cmd 'normal! gv'
end, { desc = 'Shrink treesitter selection' })

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '[vV\x16]*:n',
  callback = function() ts_selection_stack = {} end,
})

-- Custom language-agnostic dispatcher lives at lua/custom/lang/ — currently
-- disabled in favor of neotest + rustaceanvim. Re-enable by un-commenting:
-- require 'custom.lang'
