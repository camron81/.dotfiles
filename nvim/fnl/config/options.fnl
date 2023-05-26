(module config.options
  {autoload {nvim aniseed.nvim}})

(let [option-table 
      {:autochdir true
       :clipboard "unnamedplus"
       :expandtab true
       :fileencoding "utf-8"
       :ignorecase true
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
       :termguicolors true
       :timeoutlen 1000
       :undofile true
       :updatetime 500
       :writebackup false
       :wrap false
       :scrolloff 8
       :sidescrolloff 8}]
  (each [key value (pairs option-table)]
    (tset nvim.o key value)))
