-- options
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = 0

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.completeopt = "menuone,noinsert"
vim.opt.confirm = true

-- keymaps
vim.keymap.set("n", "<C-h>", vim.cmd.Ex)
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- plugins
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

require("lazy").setup({
  { -- rose-pine colorscheme
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          italic = false,
        },
        highlight_groups = {
          Visual = { reverse = true },
        },
      })
      vim.cmd.colorscheme("rose-pine")
    end,
  },

  { -- lsp
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf })
          end

          map("gd", vim.lsp.buf.definition)
          map("K", vim.lsp.buf.hover)
          map("<leader>rn", vim.lsp.buf.rename)
          map("<leader>ca", vim.lsp.buf.code_action)
          map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
          map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
        end,
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        ts_ls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })

      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },

  { -- mini
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.completion").setup()
      require("mini.pairs").setup()

      local map_multistep = require("mini.keymap").map_multistep

      map_multistep("i", "<Tab>",   { "pmenu_next" })
      map_multistep("i", "<S-Tab>", { "pmenu_prev" })
      map_multistep("i", "<CR>",    { "pmenu_accept", "minipairs_cr" })
      map_multistep("i", "<BS>",    { "minipairs_bs" })

      local pick = require("mini.pick")
      pick.setup()

      vim.keymap.set("n", "<C-p>", pick.builtin.files)
      vim.keymap.set("n", "<C-g>", pick.builtin.grep_live)
    end,
  },

  { -- treesitter
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = { "lua", "markdown", "typescript", "vimdoc" }
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require(\"nvim-treesitter\").indentexpr()"
        end
      })
    end,
  }
})
