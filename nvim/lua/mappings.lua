require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<Space><Space>", "<cmd>Telescope find_files<cr>", { desc = "find files" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
