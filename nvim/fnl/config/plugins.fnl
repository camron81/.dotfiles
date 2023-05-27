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
  :Olical/conjure {}
  :PaterJason/cmp-conjure {}
  :folke/which-key.nvim {}
  :janet-lang/janet.vim {}
  :gpanders/nvim-parinfer {}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/cmp-cmdline {}
  :hrsh7th/cmp-path {}
  :hrsh7th/nvim-cmp {:mod "cmp"}
  :lewis6991/gitsigns.nvim {}
  :lewis6991/impatient.nvim {}
  :nvim-telescope/telescope.nvim {:mod "telescope" :requires [[:nvim-lua/plenary.nvim]]}
  :nvim-tree/nvim-tree.lua {:mod "nvim-tree" :requires [[:nvim-tree/nvim-web-devicons]]}
  :nvim-treesitter/nvim-treesitter {:mod :treesitter} 
  :rebelot/kanagawa.nvim {}
  :terrortylor/nvim-comment {}
  :wbthomason/packer.nvim {}
  :windwp/nvim-autopairs {:mod "autopairs"})

(let [(ok? gitsigns) (pcall require :gitsigns)]
  (when ok?
    (gitsigns.setup)))

(let [(ok? kanagawa) (pcall require :kanagawa)]
  (when ok?
    (set nvim.o.termguicolors true)
    (kanagawa.load "dragon")))

(let [(ok? nv-comment) (pcall require :nvim_comment)]
  (when ok?
    (nv-comment.setup)))

(let [(ok? which-key) (pcall require :which-key)]
  (when ok?
    (which-key.setup)))
