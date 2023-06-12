(module config.plugins.autopairs)
(import-macros {: safe-require} :macros)

(def- lisps [:clojure :fennel :lisp :scheme :scheme.guile])

(let [autopairs (safe-require :nvim-autopairs)]
  (autopairs.setup)
  (let [quote-rule (autopairs.get_rule "'")
        quasi-rule (autopairs.get_rule "`")]
    (tset (. quote-rule 1) :not_filetypes lisps)
    (tset quasi-rule :not_filetypes lisps)))
  
