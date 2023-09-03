local M = {}

function M.set_leader_key(keymap)
    vim.g.mapleader = keymap
end

function M.setup()
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

    -- Move lines up and down
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

    -- Keep the cursor in place while joining lines
    vim.keymap.set("n", "J", "mzJ`z")

    -- Scroll up & down inside the buffer while keeping the cursor in middle
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<C-u>", "<C-u>zz")

    -- Show search results while keeping the cursor in middle
    vim.keymap.set("n", "n", "nzzzv")
    vim.keymap.set("n", "N", "Nzzzv")

    -- greatest remap ever
    vim.keymap.set("x", "<leader>p", [["_dP]])

    -- next greatest remap ever : asbjornHaland
    vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
    vim.keymap.set("n", "<leader>Y", [["+Y]])

    -- delete but don't copy
    vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

    vim.keymap.set("n", "Q", "<nop>")
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

    vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
    vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
    vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
    vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

    -- Search & replace in the entire buffer
    vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
end

return M
