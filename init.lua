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

-- auto install lazy.nvim package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=11.17.1', lazyrepo, lazypath }) -- this version is locked use 'stable' if you want updates
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

lazy.setup({ 
    { 
        'vague2k/vague.nvim', -- vague colorscheme
        tag = 'v1.4.1',
    },
    { 
        'neovim/nvim-lspconfig', -- lsp prebuilt configurations
        tag = 'v2.4.0',
    }, 
    {
        'Saghen/blink.cmp', -- lsp completion engine 
        tag = 'v1.6.0',
    },
    {
        'nvim-treesitter/nvim-treesitter', -- syntax highlighting
        tag = 'v0.10.0',
    },
})

-- setup colorscheme 
local vague = require('vague');

vague.setup({
    style = {
        strings = 'none',
    },
})
 
vim.cmd.colorscheme('vague')

-- setup lsp and completions
local blink = require('blink.cmp')

blink.setup({
    term = { enabled = false }, -- not try to complete in terminal mode
    keymap = { -- setup your prefered keymaps
        preset = 'none',
        ['<c-k>'] = { 'select_prev' },
        ['<c-j>'] = { 'select_next' },
        ['<c-space>'] = { 'show' },
        ['<tab>'] = { 'accept', 'fallback' },
    },
    completion = {
        documentation = { -- show documentation for selected item if possible
            auto_show = true,
            auto_show_delay_ms = 0
        },
        menu = {
            draw = {
                columns = { -- draw the completion menu
                    { 'label', 'label_description', gap = 1 },
                    { 'kind' }
                }
            }
        }
    },
    fuzzy = { -- use lua implementation instead of the rust one
        implementation = 'lua'
    },
})

local blink_capabilities = blink.get_lsp_capabilities() -- get completion capabilities
blink_capabilities.textDocument.completion.completionItem.snippetSupport = false -- disable snippets

-- merge completion capabilities with default capabilities
local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    blink_capabilities
)

--- setup and enable clangd lsp
vim.lsp.config('clangd', {
    capabilities = capabilities,
})
vim.lsp.enable('clangd') 

-- enable inline diagnostics
vim.diagnostic.config({
    virtual_text = {},
})

-- syntax highlighting
local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
    ensure_installed = { 'c', 'cpp' }, -- auto install parsers for c and c++
})
