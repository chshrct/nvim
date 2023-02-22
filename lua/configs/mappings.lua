-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal mode
vim.keymap.set("i", "jj", "<Esc>")

-- better up/down
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
vim.keymap.set(
  "n",
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- keep cursor after concat lines
vim.keymap.set("n", "J", "mzJ`z")

-- vertical center movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- disable highlight search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- format with LSP
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)

-- Neotree
vim.keymap.set("n", "<leader>es", ":Neotree toggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>ef", ":Neotree<CR>", { silent = true })
vim.keymap.set(
  "n",
  "<leader>eg",
  ":Neotree float git_status<CR>",
  { silent = true }
)
vim.keymap.set("n", "<leader>eb", ":Neotree buffers<CR>", { silent = true })
