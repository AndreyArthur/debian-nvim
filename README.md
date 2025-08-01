# Basic neovim 0.11.3 configuration for c/c++ development in Debian 12

Note: This repo was specially made for a presentation in Debian Day 2025 at Santos - SP, Brazil.

## Setup and installation

The first thing we'll need to do is to update our apt database so we run:

```sh
sudo apt update
sudo apt upgrade
```

And install basic tools:

```sh
sudo apt install build-essential cmake wget curl git vim
```

Add llvm apt public key:

```sh
wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
```

Then, into /etc/apt/sources.list add these lines:

```sh
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm main
# 19 
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-19 main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-19 main
# 20 
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-20 main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-20 main
# 21 
deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-21 main
deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-21 main
```

Update the database:

```sh
sudo apt update
```

Install the tools we'll need for our neovim setup:

```
sudo apt install ripgrep clang clangd clang-format
```

Now, we'll build neovim 0.11.3 from source:

```sh
git clone https://github.com/neovim/neovim --branch=v0.11.3 --depth=1
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..
rm -rf neovim
```

Cool, now we have installed all the software we need, let's start configuring neovim.

## Neovim configuration.

Let's configure neovim step by step, remember that neovim configurations are not settings, but scripts, so, you need to reopen neovim for it to load the new config.

So open neovim in your init.lua:

```sh
nvim ~/.config/nvim/init.lua
```

Starting with basic native neovim configs:

```lua
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
```

Then we setup our plugin manager:

```lua
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

lazy.setup({ })
```
