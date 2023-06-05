(module config.plugins
  {require {c    config.core
            nvim aniseed.nvim}})

;   :PaterJason/cmp-conjure {}
;   :hrsh7th/cmp-buffer {}
;   :hrsh7th/cmp-cmdline {}
;   :hrsh7th/cmp-nvim-lsp {}
;   :hrsh7th/cmp-path {}
;   :hrsh7th/nvim-cmp {:mod "cmp"}

(c.use-plugins
  [{:name "autopairs"  :repo "windwp/nvim-autopairs" :config true}
   {:name "aniseed"    :repo "Olical/aniseed"}
   {:name "comments"   :repo "terrortylor/nvim-comment"}
   {:name "conjure"    :repo "Olical/conjure" :config true}
   {:name "gitsigns"   :repo "lewis6991/gitsigns.nvim"}
   {:name "guile"      :repo "HiPhish/guile.vim"}
   {:name "impatient"  :repo "lewis6991/impatient.nvim"}
   {:name "janet"      :repo "janet-lang/janet.vim"}
   {:name "nvim-tree" 
    :repo ["nvim-tree/nvim-tree.lua" 
            {:requires ["nvim-tree/nvim-web-devicons"]}]
    :config true}
   {:name "packer"     :repo "wbthomason/packer.nvim"}
   {:name "parinfer"   :repo "gpanders/nvim-parinfer"}
   {:name "telescope"
    :repo ["nvim-telescope/telescope.nvim" 
            {:requires "nvim-lua/plenary.nvim"}]
    :config true}
   {:name "theme"      :repo "rebelot/kanagawa.nvim"}
   {:name "treesitter" :repo "nvim-treesitter/nvim-treesitter" :config true}
   {:name "which-key"  :repo "folke/which-key.nvim" :config true}])

(let [(ok? gitsigns) (pcall require :gitsigns)]
  (if ok?
    (gitsigns.setup)
    (print "config error: gitsigns plugin could not be loaded")))

(let [(ok? kanagawa) (pcall require :kanagawa)]
  (if ok?
    (kanagawa.load "dragon")
    (print "config error: kanagawa plugin could not be loaded")))

(let [(ok? nv-comment) (pcall require :nvim_comment)]
  (if ok?
    (nv-comment.setup)
    (print "config error: nvim_comment plugin could not be loaded")))

(let [(ok? which-key) (pcall require :which-key)]
  (if ok?
    (which-key.register
      {:p {:name "plugin"
           :c ["<cmd>PackerClean<cr>" "clean"]
           :s ["<cmd>PackerSync<cr>" "sync"]
           :S ["<cmd>PackerStatus<cr>" "status"]}}
      {:prefix "<leader>"})
    (print "config error: which-key plugin could not be loaded")))
