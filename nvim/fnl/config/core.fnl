(module config.core
  {require {nvim aniseed.nvim
            mappings config.mappings
            plugins config.plugins}})

(defn set-options! [option-table]
  (each [key value (pairs option-table)]
    (tset nvim.o key value)))

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

(set-options! options)
