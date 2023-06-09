(module config.plugins
  {require {c    config.core
            nvim aniseed.nvim}})
(import-macros {: safe-require : plugin-config : plugin-loadable?} :macros)

(c.use-plugins 
  ["HiPhish/guile.vim"               
    "Olical/aniseed"                  
    "Olical/conjure"
    "folke/which-key.nvim"
    "gpanders/nvim-parinfer"          
    "janet-lang/janet.vim"           
    "jose-elias-alvarez/null-ls.nvim"
    "lewis6991/gitsigns.nvim"         
    "lewis6991/impatient.nvim"        
    "neovim/nvim-lspconfig"
    "nvim-treesitter/nvim-treesitter"
    "rebelot/kanagawa.nvim"           
    "terrortylor/nvim-comment"        
    "wbthomason/packer.nvim"          
    "williamboman/mason.nvim" ; For Testing
    "windwp/nvim-autopairs"
    ["hrsh7th/nvim-cmp" 
     {:requires ["PaterJason/cmp-conjure" "hrsh7th/cmp-buffer" "hrsh7th/cmp-cmdline" 
                 "hrsh7th/cmp-nvim-lsp"   "hrsh7th/cmp-path"   "L3MON4D3/LuaSnip" 
                 "saadparwaiz1/cmp_luasnip"]}]
    ["nvim-telescope/telescope.nvim" {:requires ["nvim-lua/plenary.nvim"]}] 
    ["nvim-tree/nvim-tree.lua" {:requires ["nvim-tree/nvim-web-devicons"]}]]) 

(plugin-config :autopairs)
(plugin-config :cmp)
(plugin-config :lsp)
(plugin-config :nvim-tree)
(plugin-config :telescope)
(plugin-config :treesitter)
(plugin-config :which-key)

(let [gitsigns (safe-require :gitsigns)]
  (gitsigns.setup))
 
(let [kanagawa (safe-require :kanagawa)]
  (kanagawa.load "dragon"))

; For Discovery
(let [mason (safe-require :mason)]
  (mason.setup))

(let [nv-comment (safe-require :nvim_comment)]
  (nv-comment.setup))
