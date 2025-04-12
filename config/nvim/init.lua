local o = vim.opt;
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local map = vim.api.nvim_set_keymap
local mapOptions = { noremap = true }

-- Leaders
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- Local config
o.autoindent     = true     -- uses the indent from the previous line
o.tabstop        = 2        -- number of columns occupied by a tab
o.softtabstop    = 2        -- see multiple spaces as tabstops
o.shiftwidth     = 2        -- width for autoindents
o.expandtab      = true     -- converts tabs to white space

-- Autocomplete menu
vim.g.wildmode = "longest:full"

-- Autoread
o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Line numbers
o.number = true
o.relativenumber = true;
autocmd("InsertEnter", {
  pattern = {"*"},
  command = "set norelativenumber"
});
autocmd("InsertLeave", {
  pattern = {"*"},
  command = "set relativenumber"
});

-- Git mappings
map('n',  '<Leader>gs',  ':Git status ',  mapOptions)
map('n',  '<Leader>gc',  ':Git commit ',  mapOptions)
map('n',  '<Leader>ga',  ':Git add ',     mapOptions)
map('n',  '<Leader>gd',  ':Git diff ',    mapOptions)

-- Tabbed editing mappings
map('n',  ',,',  ':tabnew<CR>',   mapOptions)
map('n',  ',.',  ':tabnext<CR>',  mapOptions)
map('n',  '.,',  ':tabpre<CR>',   mapOptions)

-- Fuzzy file completion mappings
map('n',  '<Leader>ff',  ':Telescope find_files<CR>',  mapOptions)
map('n',  '<Leader>fg',  ':Telescope live_grep<CR>',   mapOptions)
map('n',  ';',           ':Telescope buffers<CR>',     mapOptions)

-- Quickfix list mappings
map('n',  '<C-m>',  ':cprevious<CR>',  mapOptions);
map('n',  '<C-n>',  ':cnext<CR>',      mapOptions);
map('n',  '<C-c>',  ':cclose<CR>',     mapOptions);

-- Vim-go mappings
local function mapgo (mode, key, command, options)
  autocmd('FileType', {
    pattern = 'go',
    callback = function()
      map(mode, key, command, options)
    end
  })
end
mapgo('n', '<Leader>b', '<Plug>(go-build)', mapOptions);
mapgo('n', '<Leader>r', '<Plug>(go-run)', mapOptions);
mapgo('n', '<Leader>t', '<Plug>(go-test)', mapOptions);
mapgo('n', '<Leader>c', '<Plug>(go-coverage-toggle)', mapOptions);
mapgo('n', '<Leader>d', ':GoDecls<CR>', mapOptions);

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

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      "tpope/vim-fugitive"
    },
    {
      'tpope/vim-rhubarb'
    },
    {
      "godlygeek/tabular"
    },
    {
      "ellisonleao/gruvbox.nvim", opts = {
        italic = {
          strings = false
        }
      }
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
      'nvim-telescope/telescope.nvim', branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      'neoclide/coc.nvim',
      build = 'npm ci'
    },
    {
      'fatih/vim-go'
    },
    {
      'kien/ctrlp.vim'
    },
    {
      'google/vim-jsonnet'
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})

vim.cmd("colorscheme gruvbox")

-- statusline
require('lualine').setup({
  sections = {
    lualine_a = {}
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename',
        path = 1
      }
    }
  }
})

-- lsp
require 'coc'
command('InstallCompletion', function()
  vim.cmd('CocInstall coc-phpls coc-go coc-json coc-tsserver coc-java coc-lua')
end, {})
