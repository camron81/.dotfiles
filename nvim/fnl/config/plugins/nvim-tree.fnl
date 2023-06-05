(module config.plugins.nvim-tree
  {autoload {nvim aniseed.nvim}})

(defn- safe-require [module-name]
  (let [(ok? mod) (pcall require module-name)]
    (if ok? mod nil)))

(def- modules 
  [(safe-require :nvim-tree)
   (safe-require :nvim-web-devicons)
   (safe-require :which-key)])

(match modules
  [nil _ _] (print "nvim-tree: failed to load nvim-tree plugin")
  [_ nil _] (print "nvim-tree: failed to load nvim-web-devicons plugin")
  [_ _ nil] (print "nvim-tree: failed to load which-key plugin")

  [nvim-tree webdev-icons which-key]
  (do 
    (webdev-icons.set_icon 
      {:fnl {:icon "" :color "#428850" :name "Fennel"}})

    (nvim-tree.setup
      {:respect_buf_cwd true
       :git {:enable false}
       :modified {:enable true}
       :actions {:open_file {:quit_on_open true}}
       :renderer {:group_empty true
                  :indent_markers {:enable true}
                  :icons {:webdev_colors false
                          :glyphs {:modified ""}}}})

    (which-key.register
      {:f {:e ["<cmd>NvimTreeToggle<cr>" "file explorer"]}}
      {:prefix "<leader>"})))
