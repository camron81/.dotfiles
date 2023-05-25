(module config.plugins.cmp
  {autoload {nvim aniseed.nvim}})

(let [(ok? cmp) (pcall require :cmp)]
  (when ok?
    (cmp.setup
      {:sources [{:name "conjure"}
                 {:name "buffer"}
                 {:name "path"}]
       :window {:documentation (cmp.config.window.bordered)}
       :mapping (cmp.mapping.preset.insert
                  {"<C-b>" (cmp.mapping.scroll_docs -4) 
                   "<C-f>" (cmp.mapping.scroll_docs 4)
                   "<C-Space>" (cmp.mapping.complete)
                   "<C-e>" (cmp.mapping.abort)
                   "<CR>" (cmp.mapping.confirm {:select true})})})))
