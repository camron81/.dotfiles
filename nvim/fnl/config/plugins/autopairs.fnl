(module config.plugins.autopairs
  {autoload {autopairs :nvim-autopairs}})

(def- lisps [:clojure :fennel :lisp :scheme :scheme.guile])

(autopairs.setup)

(let [quote-rule (autopairs.get_rule "'")
      quasi-rule (autopairs.get_rule "`")]
  (tset (. quote-rule 1) :not_filetypes lisps)
  (tset quasi-rule :not_filetypes lisps))
