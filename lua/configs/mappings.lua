vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)

-- Neotree
vim.keymap.set("n", "<leader>es", ":Neotree toggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>ef", ":Neotree<CR>", { silent = true })
vim.keymap.set("n", "<leader>eg", ":Neotree float git_status<CR>", { silent = true })
vim.keymap.set("n", "<leader>eb", ":Neotree buffers<CR>", { silent = true })
