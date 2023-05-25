(module config.init
  {require {nvim aniseed.nvim
            options config.options
            keymaps config.keymaps
            plugins config.plugins}})

(plugins.use
  :wbthomason/packer.nvim {}
  :HiPhish/guile.vim {}
  :lewis6991/impatient.nvim {}
  :Olical/aniseed {}
  :Olical/conjure {}
  :gpanders/nvim-parinfer {}
  :rebelot/kanagawa.nvim {})

;; Conjure
(set nvim.g.conjure#filetype#scheme "conjure.client.guile.socket")
(set nvim.g.conjure#client#guile#socket#pipename "/home/ethan/guile.socket")

(nvim.command "colorscheme kanagawa-dragon")
