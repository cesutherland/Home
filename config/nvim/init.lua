-- Local config
local o = vim.opt;

o.autoindent     = true     -- uses the indent from the previous line
o.tabstop        = 2        -- number of columns occupied by a tab
o.softtabstop    = 2        -- see multiple spaces as tabstops
o.shiftwidth     = 2        -- width for autoindents
o.expandtab      = true     -- converts tabs to white space

-- Mappings
local map = vim.api.nvim_set_keymap
local options = { noremap = true }

map('n',  '<Leader>gs',  ':Git status ',  options)
map('n',  '<Leader>gc',  ':Git commit ',  options)
map('n',  '<Leader>ga',  ':Git add ',     options)
map('n',  '<Leader>gd',  ':Git diff ',    options)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      "tpope/vim-fugitive"
    },
    {
      "godlygeek/tabular"
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "delek" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
