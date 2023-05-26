(module config.plugins.cmp
  {autoload {nvim aniseed.nvim}})

(set nvim.o.completeopt "menuone,noselect")

(def- kind_icons {:Text " "
                  :Method "m "
                  :Function "󰡱 "
                  :Constructor " "
                  :Field " "
                  :Variable "󰫧 "
                  :Class " " 
                  :Interface "  "
                  :Module " "
                  :Property " "
                  :Unit " "
                  :Value " "
                  :Enum " "
                  :Keyword " "
                  :Snippet " "
                  :Color " "
                  :File " "
                  :Reference " "
                  :Folder " "
                  :EnumMember " "
                  :Constant " "
                  :Struct " "
                  :Event " "
                  :Operator " "
                  :TypeParameter " "})

(defn- cmp-format [entry vim_item]
  (set vim_item.kind 
       (string.format "%s %s"
                      (. kind_icons vim_item.kind)
                      vim_item.kind))
  vim_item)

(let [(ok? cmp) (pcall require :cmp)]
  (when ok?
    (cmp.setup
      {:sources [{:name "conjure"}
                 {:name "buffer"}
                 {:name "path"}]
       :window {:documentation (cmp.config.window.bordered)}
       :formatting {:fields ["kind" "abbr"]
                    :format cmp-format}
       :mapping (cmp.mapping.preset.insert
                  {"<C-b>" (cmp.mapping.scroll_docs -4) 
                   "<C-f>" (cmp.mapping.scroll_docs 4)
                   "<C-Space>" (cmp.mapping.complete)
                   "<C-e>" (cmp.mapping.abort)
                   "<CR>" (cmp.mapping.confirm {:select true})})})))
