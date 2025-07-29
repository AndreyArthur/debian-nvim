vim.opt.number = true -- line numbers: allowed
vim.opt.relativenumber = true -- relative line numbers: allowed

vim.opt.swapfile = false -- save swap files: not allowed
vim.opt.backup = false -- backup all written files: not allowed
vim.opt.writebackup = false -- backup current file: not allowed
vim.opt.hidden = false -- exit buffer without saving: not allowed
vim.opt.undofile = true -- persist undo history in file: allowed

vim.opt.splitbelow = true -- create a window below when splitting: always
vim.opt.splitright = true -- create a window right when splitting: always

vim.opt.expandtab = true -- tabs as spaces: allowed
vim.opt.tabstop = 4 -- spaces for each tab when showing: 4
vim.opt.softtabstop = 4 -- spaces for each tab when editing: 4

vim.opt.shiftwidth = 0 -- characters for each indent level: use tabstop value
vim.opt.autoindent = true -- start newlines with same indentation as above: allowed
vim.opt.smartindent = true -- automatically detect new indentation levels: allowed
vim.opt.wrap = false -- line wrapping: nowrap

vim.opt.signcolumn = 'yes' -- show signcolumn: always
vim.opt.cursorline = true -- highlight current cursor line: allowed 
vim.opt.colorcolumn = { 81, 121 } -- columns to indicate line width: 80, 120
vim.opt.background = 'dark' -- background theme: dark

vim.opt.fileencoding = 'utf-8' -- default encoding: utf-8
vim.opt.mouse = '' -- mouse option: disabled
vim.opt.showtabline = 2 -- tabline option: always

vim.g.mapleader = ' ' -- set space as leader key

local opts = { noremap = true }
vim.keymap.set('n', '<leader>r', '<cmd>source<cr>', opts) -- reload config

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function ()
        vim.highlight.on_yank({ higroup = 'Visual' })
    end
})

vim.cmd.colorscheme('unokai') -- set colorscheme
