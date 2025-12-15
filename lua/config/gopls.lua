vim.lsp.enable("gopls")

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
      },
    },
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'gomod' },
  callback = function() vim.treesitter.start() end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Organize imports using code action
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local clients = vim.lsp.get_clients({bufnr = bufnr, name = "gopls"})
    
    for _, client in ipairs(clients) do
      local response = client.request_sync("textDocument/codeAction", params, 1000, bufnr)
      if response and response.result then
        for _, action in pairs(response.result) do
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
          end
        end
      end
    end
    
    -- Apply formatting
    vim.lsp.buf.format({ timeout_ms = 1000 })
  end,
})