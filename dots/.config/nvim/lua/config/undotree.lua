function GetDir()
    if vim.loop.os_uname().sysname == 'Windows_NT' then
        return os.getenv("USERPROFILE") .. "/.vim/undodir"
    else
        return os.getenv("HOME") .. "/.vim/undodir"
    end
end

vim.opt.undodir = GetDir()
vim.opt.undofile = true
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
