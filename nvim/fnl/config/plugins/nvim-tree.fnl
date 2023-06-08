(module config.plugins.nvim-tree
  {autoload {nvim aniseed.nvim}})
(import-macros {: safe-require} :macros)

(let [webdev-icons (safe-require :nvim-web-devicons)
      nvim-tree    (safe-require :nvim-tree)]
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
                        :glyphs {:modified ""}}}}))
