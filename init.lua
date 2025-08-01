vim.opt.number = true -- allow line numbers
vim.opt.relativenumber = true -- allow relative line numbers

vim.opt.swapfile = false -- don't save swap files
vim.opt.backup = false -- don't backup any written files
vim.opt.writebackup = false -- don't backup current file
vim.opt.hidden = false -- don't allow to exit buffer without saving
vim.opt.undofile = true -- persist undo history

vim.opt.splitbelow = true -- always create new window below when horizontal splitting
vim.opt.splitright = true -- always create new window right when vertical splitting

vim.opt.expandtab = true -- use tabs as spaces
vim.opt.tabstop = 4 -- show each tab as 4 spaces
vim.opt.softtabstop = 4 -- treat every 4 spaces as a tab

vim.opt.shiftwidth = 0 -- set characters for each indent level as equal to the tabstop value
vim.opt.autoindent = true -- start new lines with same indentation as the above line
vim.opt.smartindent = true -- automatically detect new indentation levels inside delimiters
vim.opt.wrap = false -- disable line wrapping (breaking)

vim.opt.signcolumn = 'yes' -- always show the signcolumn to avoid flickering
vim.opt.cursorline = true -- highlight current cursor line
vim.opt.colorcolumn = { 81, 121 } -- columns to indicate line width
vim.opt.background = 'dark' -- color option

vim.opt.fileencoding = 'utf-8' -- set default encoding
vim.opt.mouse = '' -- disable mouse
vim.opt.showtabline = 2 -- always show tabline

vim.opt.winborder = 'rounded' -- set all borders to be rounded

vim.g.mapleader = ' ' -- set space as leader key

local opts = { noremap = true } -- set the default keymap options to no remap

vim.keymap.set('n', '<leader>tt', '<cmd>terminal<cr>', opts) -- enter in terminal mode
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', opts) -- esc in terminal mode

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function ()
        vim.highlight.on_yank({ higroup = 'Visual' })
    end,
})

local CWD = '%:p:h' -- set neovim cwd string as a constant

-- always change neovim dir do the current working directory when entering
vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    callback = function ()
        vim.api.nvim_set_current_dir(vim.fn.expand(CWD)) 
    end,
})
