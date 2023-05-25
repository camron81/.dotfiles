(module config.plugins
  {autoload {a aniseed.core
             : packer}})

(defn safe-require-plugin-config [name]
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
  :gpanders/nvim-parinfer {}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/cmp-cmdline {}
  :hrsh7th/cmp-path {}
  :hrsh7th/nvim-cmp {:mod :cmp}
  :lewis6991/impatient.nvim {}
  :rebelot/kanagawa.nvim {:mod :kanagawa}
  :wbthomason/packer.nvim {})

