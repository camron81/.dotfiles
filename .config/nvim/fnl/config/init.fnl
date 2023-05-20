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
  :eraserhd/parinfer-rust {})

;; Conjure
(set nvim.g.conjure#filetype#scheme "conjure.client.guile.socket")
(set nvim.g.conjure#client#guile#socket#pipename "/home/ethan/guile.socket")

;; Parinfer
(vim.cmd "NoMatchParen")
(set nvim.g.parinfer_dylib_path "/home/ethan/parinfer-rust-linux.so")
