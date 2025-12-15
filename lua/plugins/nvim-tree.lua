return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, but almost always used
  },
  config = function()
    require("nvim-tree").setup({})
  end,
}
