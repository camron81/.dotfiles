(module config.plugins
  {require {c    config.core
            nvim aniseed.nvim}})

(import-macros {: safe-require : plugin-config : plugin-loadable?} :macros)
 
(c.use-plugins 
  ["HiPhish/guile.vim"               
   "Olical/aniseed"                  
   "Olical/conjure"
   "TimUntersberger/neogit"
   "folke/which-key.nvim"
   "gpanders/nvim-parinfer"          
   "janet-lang/janet.vim"           
   "jose-elias-alvarez/null-ls.nvim"
   "lewis6991/gitsigns.nvim"         
   "lewis6991/impatient.nvim"        
   "mg979/vim-visual-multi"
   "neovim/nvim-lspconfig"
   "nvim-lua/plenary.nvim"
   "nvim-telescope/telescope.nvim"
   "rebelot/kanagawa.nvim"           
   "terrortylor/nvim-comment"        
   "wbthomason/packer.nvim"          
   "windwp/nvim-autopairs"
   ["ggandor/leap.nvim" {:requires ["tpope/vim-repeat"]}]
   ["nvim-neorg/neorg" {:run "Neorg sync-parsers"}]
   ["nvim-tree/nvim-tree.lua" {:requires ["nvim-tree/nvim-web-devicons"]}] 
   ["nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"}]
   ["hrsh7th/nvim-cmp" 
     {:requires ["PaterJason/cmp-conjure" "hrsh7th/cmp-buffer" "hrsh7th/cmp-cmdline" 
                 "hrsh7th/cmp-nvim-lsp"   "hrsh7th/cmp-path"   "L3MON4D3/LuaSnip" 
                 "saadparwaiz1/cmp_luasnip"]}]])

(plugin-config :autopairs)
(plugin-config :cmp)
(plugin-config :lsp)
(plugin-config :neorg)
(plugin-config :nvim-tree)
(plugin-config :null-ls)
(plugin-config :telescope)
(plugin-config :treesitter)
(plugin-config :which-key)

(let [gitsigns (safe-require :gitsigns)]
  (gitsigns.setup))
 
(let [kanagawa (safe-require :kanagawa)]
  (kanagawa.load "dragon"))

(let [leap (safe-require :leap)]
  (leap.add_default_mappings))

(let [neogit (safe-require :neogit)]
  (neogit.setup))

(let [nv-comment (safe-require :nvim_comment)]
  (nv-comment.setup))
