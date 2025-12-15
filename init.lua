require("config.lazy")
require("config.lspconfig")
require("config.telescope")
require("config.gopls")

vim.keymap.set({ "n", "i", "v", "t" }, "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "File tree" })
vim.keymap.set({ "n", "i", "v", "t" }, "<C-a>", "<Esc><cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

vim.cmd.colorscheme "catppuccin"