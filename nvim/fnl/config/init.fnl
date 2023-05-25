(module config.init
  {require {nvim aniseed.nvim
            plugins config.plugins
            options config.options
            keymaps config.keymaps}})

;; Conjure
(set nvim.g.conjure#filetype#scheme "conjure.client.guile.socket")
(set nvim.g.conjure#client#guile#socket#pipename "/home/ethan/guile.socket")
