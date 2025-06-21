local opt = vim.opt

-- 行番号の表示
opt.number = true
-- opt.relativenumber = true

-- タブとインデントの設定
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- 検索設定
opt.ignorecase = true
opt.smartcase = true



-- lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Neotree
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", opts = {}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
    
  }, 
  {"nvim-lua/plenary.nvim"},
  {"nvim-tree/nvim-web-devicons"},
  {"MunifTanjim/nui.nvim"},

  { "folke/snacks.nvim", opts = { dashboard = { enabled = true, example = 'files' } } },

  {"mason-org/mason.nvim",opts = {}},











})

