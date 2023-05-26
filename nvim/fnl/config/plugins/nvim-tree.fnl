(module config.plugins.nvim-tree
  {autoload {nvim aniseed.nvim
             mapping lib.mapping}})

(set nvim.g.loaded_netrw 1)
(set nvim.g.netrwPlugin 1)
(set nvim.o.autochdir true)

(let [(ok? webdev-icons) (pcall require :nvim-web-devicons)]
  (when ok?
    (webdev-icons.set_icon {:fnl {:icon "" :color "#428850" :name "Fennel"}})))

(let [(ok? nvim-tree) (pcall require :nvim-tree)]
  (when ok?
    (nvim-tree.setup 
       {:respect_buf_cwd true
        :git {:enable false}
        :modified {:enable true}
        :actions {:open_file {:quit_on_open true}}
        :renderer {:group_empty true
                   :indent_markers {:enable true}
                   :icons {:webdev_colors false
                           :glyphs {:modified ""}}}})
    (mapping.set-keymaps [[:n :<leader>fe ":NvimTreeToggle<cr>"]])))

