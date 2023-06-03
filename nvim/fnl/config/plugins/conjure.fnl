(module config.plugins.conjure
  {autoload {nvim aniseed.nvim}})

(set nvim.g.conjure#filetype#scheme "conjure.client.guile.socket")
(set nvim.g.conjure#client#guile#socket#pipename "/home/ethan/guile.socket")

(let [(ok? which-key) (pcall require :which-key)]
  (if ok?
    (which-key.register
      {:e {:name "conjure-eval"
           :c {:name "comment"}}
       :g {:name "conjure-goto"}
       :l {:name "conjure-log"}
       :r {:name "conjure-reset"}}
      {:prefix "<leader>"})
    (print "conjure: failed to load which-key plugin")))
