-- --------------------------------
-- Basic Settings
-- --------------------------------
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Relative line numbers
vim.opt.cursorline = true            -- Highlight the current line
vim.opt.wrap = false                 -- Disable line wrapping
vim.opt.scrolloff = 8                -- Keep 8 lines visible around the cursor
vim.opt.sidescrolloff = 8            -- Keep 8 columns visible around the cursor
vim.opt.showmode = false             -- Disable mode display (handled by status line)
vim.opt.inccommand = 'split'         -- Live preview of search and replace
vim.opt.laststatus = 3

-- --------------------------------
-- Search Settings
-- --------------------------------
vim.opt.ignorecase = true            -- Case-insensitive searching
vim.opt.smartcase = true             -- Case-sensitive if uppercase in search
vim.opt.hlsearch = true              -- Highlight search results
vim.opt.incsearch = true             -- Incremental search

-- --------------------------------
-- Indentation
-- --------------------------------
vim.opt.autoindent = true            -- Auto-indent new lines
vim.opt.smartindent = true           -- Smart indentation
vim.opt.expandtab = true             -- Use spaces instead of tabs
vim.opt.tabstop = 2                  -- Number of spaces per tab
vim.opt.shiftwidth = 2               -- Spaces per indentation level
vim.opt.softtabstop = 2              -- Spaces per Tab during editing

-- --------------------------------
-- UI Enhancements
-- --------------------------------
vim.opt.termguicolors = true         -- Enable true color support
vim.opt.signcolumn = "yes"           -- Always show sign column
vim.opt.clipboard = "unnamedplus"    -- Use system clipboard
vim.opt.splitbelow = true            -- Horizontal splits go below
vim.opt.splitright = true            -- Vertical splits go to the right

-- --------------------------------
-- Leader Key
-- --------------------------------
vim.g.mapleader = ' ' -- Set leader key
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Save File" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Quit" })

-- --------------------------------
-- Plugin Manager (Lazy.nvim)
-- --------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  -- Essential plugins
  "nvim-lua/plenary.nvim",             -- Utility functions used by many plugins
  "nvim-treesitter/nvim-treesitter",   -- Better syntax highlighting and code parsing
  "nvim-telescope/telescope.nvim",    -- Fuzzy finder for files, buffers, and more
  "nvim-tree/nvim-tree.lua",           -- File explorer
  "nvim-lualine/lualine.nvim",         -- Status line with rich features
  "windwp/nvim-autopairs",             -- Automatically close brackets and quotes
  "nvim-tree/nvim-web-devicons",       -- File icons used in multiple plugins
  "mbbill/undotree",                   -- Visualize and navigate the undo tree
  "tpope/vim-obsession",               -- Session management plugin
  "akinsho/bufferline.nvim",           -- Tabline for buffers
  "lewis6991/gitsigns.nvim",           -- Git integration for signs, blame, and hunk actions
  "folke/trouble.nvim",                -- display errors 
  "SmiteshP/nvim-navic",
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'echasnovski/mini.icons',
      'nvim-lua/plenary.nvim'
    },
    config = function ()
      require'alpha'.setup(require'alpha.themes.theta'.config)
    end
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",         -- Easily toggle terminal windows
    version = "*",                     -- Use the latest stable version
    opts = {
      open_mapping = [[<C-\>]],        -- Keybinding to toggle the terminal
      direction = "float",             -- Use a floating window for the terminal
    },
  },


  -- Indentation
  {
    "lukas-reineke/indent-blankline.nvim", -- Display indentation guides
    main = "ibl",
    opts = {},
  },

  -- LSP and Autocompletion
  { "neovim/nvim-lspconfig" },         -- Configurations for built-in LSP
  {
    "hrsh7th/nvim-cmp",                -- Autocompletion engine
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",          -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",            -- Buffer source for nvim-cmp
      "hrsh7th/cmp-path",              -- Path source for nvim-cmp
    },
  },

  -- theme 
  { "catppuccin/nvim",                 -- Theme with multiple color options
    name = "catppuccin", 
    priority = 1000 
  },
  -- Lazy
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },


  "williamboman/mason.nvim",           -- Manage external tools (LSP, formatters, etc.)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
})
-- --------------------------------
-- Plugin Configurations
-- --------------------------------

require("tokyonight").setup({
  style = "moon", -- Choose between 'storm', 'night', and 'moon'
  transparent = true, -- Enable transparency
  terminal_colors = true, -- Enable terminal colors
  styles = {
    sidebars = "transparent", -- Set sidebars to be transparent
    floats = "transparent", -- Set floating windows to be transparent
  },
  -- Optional: Override specific highlights if needed
  on_highlights = function(highlights, colors)
    -- Customize specific highlight groups if desired
  end,
})



-- show barbecue globally
-- require('barbecue').setup {
--   -- ... your barbecue config
--   theme = 'tokyonight',
--   -- ... your barbecue config
-- }
require("barbecue.ui").toggle(true)

-- Indent-Blankline
require("ibl").setup()

-- Gitsigns
require("gitsigns").setup()
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true, desc = "Preview Hunk" })
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true, desc = "Blame Line" })
vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true, desc = "Reset Hunk" })

-- Bufferline
-- Load Tokyonight colors and utilities
local colors = require("tokyonight.colors").setup() -- Load colors with any specific style config if needed
local util = require("tokyonight.util")

-- Configure Bufferline using Tokyonight colors
require("bufferline").setup({})
vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bc", ":bd<CR>", { noremap = true, silent = true, desc = "Close Buffer" })

-- Colorscheme
vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme onedark")
-- vim.cmd.colorscheme "catppuccin-mocha"

-- Mason
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Lualine
require("lualine").setup({
  options = {
    theme = "tokyonight",
    section_separators = "",
    component_separators = "",
  },
})

-- Nvim-Tree
require("nvim-tree").setup({
  view = {
    side = "right",
    width = 30,
  },
})
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle File Explorer" })

-- Telescope
require("telescope").setup({
  defaults = {
    file_ignore_patterns = { ".git/", "node_modules/" },
  },
})
-- Telescope (File Search)
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true, desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { noremap = true, silent = true, desc = "Find Help" })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', { noremap = true, silent = true , desc = "document symbols" })

-- Autopairs
require("nvim-autopairs").setup()

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "javascript", "html", "css" },
  highlight = { enable = true },
})

-- LSP
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})

-- CMP
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- ToggleTerm (Integrated Terminal)
require("toggleterm").setup({
  size = 20,                            -- Default terminal height or width
  open_mapping = [[<C-j>]],             -- Keybinding to toggle terminal
  hide_numbers = true,                  -- Hide line numbers in the terminal
  shade_terminals = true,               -- Apply shading to terminals
  shading_factor = 2,                   -- Darken terminal by this factor
  start_in_insert = true,               -- Start in insert mode when opening
  persist_size = true,                  -- Remember terminal size
  direction = "float",                  -- Use a floating terminal
  close_on_exit = true,                 -- Close terminal when process exits
  shell = vim.o.shell,                  -- Use the default shell
  float_opts = {                        -- Options for floating terminal
    border = "curved",
    winblend = 3,
  },
})

-- Custom keybinding to toggle terminal (ensures it opens and closes)
function _G.toggle_terminal()
  local Terminal = require("toggleterm.terminal").Terminal
  if not Terminal.instances then
    vim.cmd("ToggleTerm")
  else
    vim.cmd("ToggleTermToggleAll")
  end
end

-- Terminal Integration (ToggleTerm)
vim.keymap.set("n", "<C-j>", "<cmd>lua toggle_terminal()<CR>", { noremap = true, silent = true, desc = "Toggle Terminal" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><cmd>lua toggle_terminal()<CR>", { noremap = true, silent = true, desc = "Toggle Terminal (in Terminal Mode)" })

-- trouble setup for diagnostics
require("trouble").setup()
-- Diagnostics (Trouble)
vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", { noremap = true, silent = true, desc = "Toggle Trouble" })

-- --------------------------------
-- history and persistence
-- --------------------------------
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.history = 1000

vim.cmd([[
  augroup restorecursor
    autocmd!
    autocmd bufreadpost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup end
]])

-- --------------------------------
-- session management
-- --------------------------------
-- Session Management
vim.keymap.set("n", "<leader>ss", ":mksession!<CR>", { noremap = true, silent = true, desc = "Save Session" })
vim.keymap.set("n", "<leader>sl", ":source Session.vim<CR>", { noremap = true, silent = true, desc = "Load Session" })

vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize"

-- Undo Tree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true, desc = "Undo Tree" })

-- --------------------------------
-- keybinds
-- --------------------------------

-- Define a keybinding for renaming
vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })

	
