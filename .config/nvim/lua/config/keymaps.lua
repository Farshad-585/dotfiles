-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local navigate = require("config.mux_nav").navigate

vim.keymap.set({ "n", "t" }, "<C-h>", navigate("h"), { desc = "Go to Left Window or Pane", silent = true })
vim.keymap.set({ "n", "t" }, "<C-j>", navigate("j"), { desc = "Go to Lower Window or Pane", silent = true })
vim.keymap.set({ "n", "t" }, "<C-k>", navigate("k"), { desc = "Go to Upper Window or Pane", silent = true })
vim.keymap.set({ "n", "t" }, "<C-l>", navigate("l"), { desc = "Go to Right Window or Pane", silent = true })
