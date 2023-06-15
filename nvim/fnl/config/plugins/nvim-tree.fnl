(module config.plugins.nvim-tree
  {autoload {webdev-icons :nvim-web-devicons
             nvim-tree    :nvim-tree
             api          :nvim-tree.api}})

(defn- edit-or-open []
  (let [node (api.tree.get_node_under_cursor)]
    (if (not= nil node.nodes)
      (api.node.open.edit)
      (do (api.node.open.edit)
          (api.tree.close)))))

(defn- edit-or-open-vsplit []
  (let [node (api.tree.get_node_under_cursor)]
    (if (not= nil node.nodes)
      (api.node.open.edit)
      (api.node.open.vertical))))

(defn- on-attach [bufnr]
  (api.config.mappings.default_on_attach bufnr)
  (let [opts {:buffer bufnr :noremap true :silent true :nowait true}]
    (vim.keymap.set "n" "l" edit-or-open opts)
    (vim.keymap.set "n" "L" edit-or-open-vsplit opts)
    (vim.keymap.set "n" "h" api.tree.change_root_to_parent opts)))

(webdev-icons.set_icon
   {:fnl {:icon "" :color "#428850" :name "Fennel"}})

(nvim-tree.setup
    {:respect_buf_cwd true
     :git {:enable false}
     :modified {:enable true}
     :actions {:open_file {:quit_on_open true}}
     :on_attach on-attach
     :renderer {:group_empty true
                :indent_markers {:enable true}
                :icons {:webdev_colors false
                        :glyphs {:modified ""}}}})
