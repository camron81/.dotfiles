(module config.init
  {require {nvim aniseed.nvim
            plugin config.plugin}})

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

(nvim.ex.highlight "NormalFloat ctermbg=grey guibg=grey")

(plugin.use
  :HiPhish/guile.vim {}
  :Olical/aniseed {}
  :Olical/conjure {}
  :gpanders/nvim-parinfer {})

;; Conjure
(set nvim.g.conjure#filetype#scheme "conjure.client.guile.socket")
(set nvim.g.conjure#client#guile#socket#pipename "/home/ethan/guile.socket")

