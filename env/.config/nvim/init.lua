-- SETS
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.netrw_banner = 0
vim.g.have_nerd_font = false

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.completeopt = { 'menuone', 'noinsert' }
vim.opt.confirm = true

-- KEYMAPS
vim.keymap.set('n', '<C-h>', vim.cmd.Explore)

vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- PLUGINS
vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nohlsearch')
vim.pack.add({
  'https://github.com/rose-pine/neovim',
  'https://github.com/nvim-mini/mini.pairs',
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-mini/mini.keymap',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/romus204/tree-sitter-manager.nvim',
})

-- undotree
vim.keymap.set('n', '<leader>u', require('undotree').open)

-- colorscheme
require('rose-pine').setup({
  styles = { italic = false },
  highlight_groups = { Visual = { reverse = true } },
})

vim.cmd.colorscheme('rose-pine')

-- pairs
require('mini.pairs').setup()

-- picker
local pick = require('mini.pick')

pick.setup({ source = { show = not vim.g.have_nerd_font and pick.default_show or nil } })

vim.keymap.set('n', '<C-p>', pick.builtin.files)
vim.keymap.set('n', '<C-g>', pick.builtin.grep_live)

-- lsp
local servers = {
  lua_ls = {
    on_init = function(client)
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = { version = 'LuaJIT' },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      })
    end,
    settings = { Lua = {} },
  },
  ts_ls = {},
}

local ensure_installed = vim.tbl_keys(servers)

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = ensure_installed,
})

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

require('mini.completion').setup()
local map_multistep = require('mini.keymap').map_multistep

map_multistep('i', '<Tab>',   { 'pmenu_next' })
map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>',    { 'minipairs_bs' })

-- treesitter
require('tree-sitter-manager').setup({
  ensure_installed = { 'lua', 'typescript' },
})
