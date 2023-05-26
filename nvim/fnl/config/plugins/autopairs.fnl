(module config.plugins.autopairs)

(def- lisps [:scheme :lisp :clojure :fennel])

(let [(ok? autopairs) (pcall require :nvim-autopairs)]
  (when ok?
    (autopairs.setup)
    (tset (. (autopairs.get_rule "'") 1) :not_filetypes lisps)
    (tset (autopairs.get_rule "`") :not_filetypes lisps)))

