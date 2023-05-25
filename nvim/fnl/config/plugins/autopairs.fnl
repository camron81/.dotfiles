(module config.plugins.autopairs
  {require {a aniseed.core}})

(def lisps [:scheme :lisp :clojure :fennel])

(defn disable-rule-for-filetypes [char]
  (let [autopairs (require :nvim-autopairs)]
    (a.assoc-in
      (autopairs.get_rule char)
      [1 :not_filetypes]
      lisps)))

(let [(ok? autopairs) (pcall require :nvim-autopairs)]
  (when ok?
    (autopairs.setup)
    (tset (. (autopairs.get_rule "'") 1) :not_filetypes lisps)
    (tset (autopairs.get_rule "`") :not_filetypes lisps)))

