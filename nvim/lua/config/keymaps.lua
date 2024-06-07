-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>bw", "<cmd>noautocmd w<cr>", { desc = "Save without formatting" })
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft <CR>")
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight <CR>")
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown <CR>")
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp <CR>")

-- navigate buffers
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Prev buffer" })
