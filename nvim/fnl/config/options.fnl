(module config.options
  {autoload {nvim aniseed.nvim}})

(let [option-table 
      {:clipboard "unnamedplus"
       :expandtab true
       :fileencoding "utf-8"
       :ignorecase true
       :mouse "a"
       :number true
       :numberwidth 4
       :pumheight 10
       :scrolloff 8
       :shiftwidth 2
       :showmode false
       :showtabline 0
       :sidescrolloff 8
       :smartcase true
       :smartindent true
       :splitbelow true
       :splitright true
       :swapfile false
       :tabstop 2
       :timeoutlen 1000
       :undofile true
       :updatetime 500
       :wrap false
       :writebackup false}]
  (each [key value (pairs option-table)]
    (tset nvim.o key value)))
