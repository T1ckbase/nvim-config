require 'nvchad.mappings'

  -- add yours here

-- local vim.keymap.set = vim.keymap.set

vim.keymap.del("n", "<leader>/")
vim.keymap.del("v", "<leader>/")

vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- vim.keymap.set("i", "<C-;>", "<ESC>")


-- vim.keymap.set({"n", "i"}, "\\", "<cmd> =1,10<CR>") -- test

-- vscode
vim.keymap.set("n", "<C-_>", "mzgcc`z", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<C-_>", "mzgc`z", { desc = "toggle comment", remap = true })

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = 'save file' }) -- save file

vim.keymap.set("n", "<A-k>", "<cmd> m .-2<CR>mz==j==k`z") -- move line up (n)
vim.keymap.set("n", "<A-j>", "<cmd> m .+1<CR>mz==k==j`z") -- move line down (n)
vim.keymap.set("i", "<A-k>", "<cmd> m .-2<CR><ESC>==j==kgi") -- move line up (i)
vim.keymap.set("i", "<A-j>", "<cmd> m .+1<CR><ESC>==k==jgi") -- move line down (i)
vim.keymap.set("v", "<A-k>", "<cmd> m '<-2<CR>gv=gv") -- move line up (v)
vim.keymap.set("v", "<A-j>", "<cmd> m '>+1<CR>gv=gv") -- move line down (v)

vim.keymap.set({"n", "i"}, "<A-K>", "<cmd> copy .-1<CR>") -- copy line up (n)
vim.keymap.set({"n", "i"}, "<A-J>", "<cmd> copy .<CR>") -- copy line down (n)

vim.keymap.set({"n", "i"}, "<F2>", vim.lsp.buf.rename) -- rename
