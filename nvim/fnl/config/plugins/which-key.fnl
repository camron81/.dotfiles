(module config.plugins.which-key
  {autoload {nvim aniseed.nvim}})

(let [(ok? which-key) (pcall require :which-key)]
  (if ok?
    (do (which-key.setup)
        (which-key.register
          {:f {:name "file"
               :s ["<cmd>w<cr>" "save"]
               :S ["<cmd>w!<cr>" "force save"]
               :q ["<cmd>q<cr>" "quit"]
               :Q ["<cmd>q!<cr>" "force quit"]}
           :w {:name "window"
               :h ["<C-w><S-h>" "move left"]
               :j ["<C-w><S-j>" "move down"]
               :k ["<C-w><S-k>" "move up"]
               :l ["<C-w><S-l>" "move right"]
               :v ["<C-w>v" "vertical split"]
               :s ["<C-w>s" "horizontal split"]
               :m ["<cmd>only<cr>" "maximize"]
               :q ["<C-w>q" "close window"]}
           :b {:name "buffer"
               :n ["<cmd>bnext<cr>" "next buffer"]
               :p ["<cmd>bprevious<cr>" "prev buffer"]
               :q ["<cmd>bdelete!<cr>" "close buffer"]}
           :t {:name "terminal"
               :v ["<cmd>vsplit<cr> | <cmd>terminal<cr>" "vertical terminal"]
               :s ["<cmd>split<cr> | <cmd>terminal<cr>" "horizontal terminal"]
               :m ["<cmd>terminal<cr>" "maximized terminal"]}}
          {:prefix "<leader>"})) 
   (print "config error: which-key plugin could not be loaded")))
