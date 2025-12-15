return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "delve",
        "staticcheck",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
