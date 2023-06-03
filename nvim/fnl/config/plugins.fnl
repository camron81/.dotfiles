(module config.plugins
  {autoload {nvim aniseed.nvim
             a aniseed.core
             : packer}})

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugins. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn- use [...]
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)

(use
  :HiPhish/guile.vim {}
  :Olical/aniseed {}
  :Olical/conjure {:mod "conjure"}
  :PaterJason/cmp-conjure {}
  :folke/which-key.nvim {:mod "which-key"}
  :gpanders/nvim-parinfer {}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/cmp-cmdline {}
  :hrsh7th/cmp-nvim-lsp {}
  :hrsh7th/cmp-path {}
  :hrsh7th/nvim-cmp {:mod "cmp"}
  :janet-lang/janet.vim {}
  :lewis6991/gitsigns.nvim {}
  :lewis6991/impatient.nvim {}
  :nvim-telescope/telescope.nvim 
    {:mod "telescope" 
     :requires [[:nvim-lua/plenary.nvim]]}
  :nvim-tree/nvim-tree.lua 
    {:mod "nvim-tree" 
     :requires [[:nvim-tree/nvim-web-devicons]]}
  :nvim-treesitter/nvim-treesitter {:mod :treesitter} 
  :rebelot/kanagawa.nvim {}
  :terrortylor/nvim-comment {}
  :wbthomason/packer.nvim {}
  :windwp/nvim-autopairs {:mod "autopairs"})

(let [(ok? gitsigns) (pcall require :gitsigns)]
  (if ok?
    (gitsigns.setup)
    (print "config error: gitsigns plugin could not be loaded")))

(let [(ok? kanagawa) (pcall require :kanagawa)]
  (if ok?
    (do (set nvim.g.termguicolors true)
        (kanagawa.load "dragon"))
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
