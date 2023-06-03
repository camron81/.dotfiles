(module config.plugins.autopairs)

(def- lisps [:clojure :fennel :lisp :scheme :scheme.guile])

(let [(ok? autopairs) (pcall require :nvim-autopairs)]
  (if ok?
    (do (autopairs.setup)
        (tset (. (autopairs.get_rule "'") 1) :not_filetypes lisps)
        (tset (autopairs.get_rule "`") :not_filetypes lisps))
    (print "config error: nvim-autopairs plugin could not be loaded")))

