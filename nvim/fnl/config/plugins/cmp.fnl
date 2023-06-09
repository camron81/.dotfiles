(module config.plugins.cmp)
(import-macros {: safe-require} :macros)

(def- cmp (safe-require :cmp))
(def- snip (safe-require :luasnip))

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

(defn- tab-complete [fallback]
  (if (cmp.visible)             (cmp.select_next_item)
      (snip.expandable)         (snip.expand)
      (snip.expand_or_jumpable) (snip.expand_or_jump)
      (fallback)))

(defn- shift-tab-complete [fallback]
  (if (cmp.visible)      (cmp.select_prev_item)
      (snip.jumpable -1) (snip.jump -1)
      (fallback)))

(cmp.setup
  {:snippet {:expand (fn [args] (snip.lsp_expand args.body))}
   :sources [{:name "nvim_lsp"}
             {:name "conjure"}
             {:name "luasnip"}
             {:name "buffer"}
             {:name "path"}]
   :window {:documentation (cmp.config.window.bordered)}
   :formatting {:fields ["kind" "abbr"]
                :format cmp-format}
   :mapping (cmp.mapping.preset.insert
              {"<C-b>"     (cmp.mapping.scroll_docs -4) 
               "<C-f>"     (cmp.mapping.scroll_docs 4)
               "<C-Space>" (cmp.mapping.complete)
               "<C-e>"     (cmp.mapping.abort)
               "<C-y>"     (cmp.mapping.confirm {:select true})
               "<Tab>"     (cmp.mapping tab-complete)
               "<S-Tab>"   (cmp.mapping shift-tab-complete)})})
