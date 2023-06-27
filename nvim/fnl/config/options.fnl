(module config.options
  {autoload {c    config.core
             nvim aniseed.nvim}})
(import-macros {: plugin-loadable?} :macros)

(def- base-options
  {:cindent true
   :clipboard "unnamedplus"
   :expandtab true
   :ignorecase true
   :linebreak true
   :mouse "a"
   :number true
   :pumheight 10
   :shiftwidth 4
   :showmode false
   :showtabline 0
   :smartcase true
   :smartindent true
   :splitbelow true
   :splitright true
   :swapfile false
   :timeoutlen 500
   :undofile true
   :writebackup false})

(c.set-options base-options)

(def- languages [:clojure :fennel :janet :lisp :norg :scheme :scheme.guile])
(each [_ filetype (ipairs languages)]
  (nvim.create_autocmd 
      "FileType"
      {:pattern filetype
       :command "setlocal shiftwidth=2"}))

(when (plugin-loadable? :conjure.main)
  (set nvim.g.conjure#filetype#scheme "conjure.client.guile.socket")
  (set nvim.g.conjure#client#guile#socket#pipename "/home/ethan/guile.socket"))

(when (plugin-loadable? :cmp)
  (set nvim.o.completeopt "menuone,noselect"))

(when (plugin-loadable? :kanagawa)
  (set nvim.o.termguicolors true))

(when (plugin-loadable? :neorg)
  (c.set-options {:conceallevel 2
                  :foldlevelstart 99})
  (nvim.create_autocmd
    "FileType"
    {:pattern "norg"
     :command 
     "setlocal textwidth=80 | set spell! spelllang=en_gb"}))

(when (plugin-loadable? :nvim-tree)
  (set nvim.g.loaded_netrw 1)
  (set nvim.g.netrwPlugin 1)
  (set nvim.o.autochdir true))
