-- depends on `gitlab-ci-ls` to be installed
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.gitlab-ci*.yml', '*.gitlab-ci*.yaml', '.gitlab-ci.yml', '.gitlab-ci.yaml' },
  callback = function()
    vim.lsp.start {
      name = 'gitlab_ci_ls',
      cmd = { 'gitlab-ci-ls' },
      root_dir = vim.fs.dirname(vim.fs.find({ '.gitlab-ci.yml', '.gitlab-ci.yaml' }, { upward = true })[1]),
      settings = {
        gitlabci = {
          cache = vim.fn.expand '~/.cache/gitlab-ci-ls',
        },
      },
    }
  end,
})
