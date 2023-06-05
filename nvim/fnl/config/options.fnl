(module config.options
  {autoload {c config.core
             nvim aniseed.nvim}})

(def- base-options
  {:clipboard "unnamedplus"
   :expandtab true
   :guifont "MesloLGM Regular"
   :ignorecase true
   :linebreak true
   :mouse "a"
   :number true
   :pumheight 10
   :shiftwidth 2
   :showmode false
   :showtabline 0
   :smartcase true
   :smartindent true
   :splitbelow true
   :splitright true
   :swapfile false
   :tabstop 2
   :timeoutlen 500
   :undofile true
   :writebackup false})
  
(c.set-options base-options)

(when (c.plugin-loaded? "nvim-tree")
  (set nvim.g.loaded_netrw 1)
  (set nvim.g.netrwPlugin 1)
  (set nvim.o.autochdir true))

(when (c.plugin-loaded? "theme")
  (c.set-options {:termguicolors true}))
