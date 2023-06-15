(module config.plugins.which-key
  {autoload {which-key :which-key}})
(import-macros {: plugin-loadable?} :macros)

(do (which-key.setup
      (which-key.register
        {:f {:name "file"
             :q "quit"
             :Q "force quit"
             :s "save"
             :S "force save"}
         :w {:name "window"
             :c "close"
             :m "maximize"
             :n "new"
             :q "quit"
             :s "horizontal split"
             :v "vertical split"
             :h "move left"
             :j "move down"
             :k "move up"
             :l "move right"}
         :b {:name "buffer"
             :m "show modified"
             :n "next"
             :p "previous"
             :d "delete"}
         :t {:name "terminal"
             :m "maximized"
             :s "horizontal split"
             :v "vertical split"}
         :c {:name "checkers"
             :s {:name "spelling"
                 :g "Great Britain"
                 :u "USA"}}}
        {:prefix "<leader>"}))) 

(when (plugin-loadable? :conjure.main)
  (which-key.register
    {:e {:name "conjure-eval"
         :c {:name "comment"}}
     :g {:name "go-to"}
     :l {:name "conjure-log"}
     :r {:name "conjure-reset"}}
    {:prefix "<leader>"}))

(when (plugin-loadable? :neogit)
  (which-key.register
    {:f {:g "git status"}}
    {:prefix "<leader>"}))

(when (plugin-loadable? :nvim-tree)
  (which-key.register
    {:f {:e "file explorer"}}
    {:prefix "<leader>"}))

(when (plugin-loadable? :packer)
  (which-key.register
    {:p {:name "packer"
         :c "clean"
         :s "sync"
         :S "status"}}
    {:prefix "<leader>"}))

(when (plugin-loadable? :telescope)
  (which-key.register
    {:f {:f "find files"
         :r "recent files"}
     :b {:f "find buffers"}
     :s {:name "search"
         :c "commands"
         :f "filetypes"
         :g "grep"
         :k "keymaps"
         :m "man pages"
         :o "vim options"
         :s "search in file"
         :t "treesitter"}}
    {:prefix "<leader>"}))
