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

(let [(ok? which-key) (pcall require :which-key)]
  (if ok?
    (which-key.register
      {:e {:name "conjure-eval"
           :c {:name "comment"}}
       :g {:name "conjure-goto"}
       :l {:name "conjure-log"}
       :r {:name "conjure-reset"}}
      {:prefix "<leader>"})
    (print "conjure: failed to load which-key plugin")

    (which-key.register
      {:f {:e ["<cmd>NvimTreeToggle<cr>" "file explorer"]}}
      {:prefix "<leader>"})

    (which-key.register
      {:f {:f ["<cmd>Telescope find_files hidden=true<cr>" "find files"]
           :r ["<cmd>Telescope oldfiles hidden=true<cr>" "recent files"]}
       :b {:f ["<cmd>Telescope buffers<cr>" "find buffers"]}
       :s {:name "search"
           :c ["<cmd>Telescope commands<cr>" "commands"]
           :f ["<cmd>Telescope filetypes<cr>" "filetypes"]
           :g ["<cmd>Telescope live_grep<cr>" "grep"]
           :k ["<cmd>Telescope keymaps<cr>" "keymaps"]
           :m ["<cmd>Telescope man_pages sections=ALL<cr>" "man pages"]
           :o ["<cmd>Telescope vim_options<cr>" "vim options"]
           :s ["<cmd>Telescope current_buffer_fuzzy_find<cr>" "search"]
           :t ["<cmd>Telescope treesitter<cr>" "treesitter"]}}
      {:prefix "<leader>"})))
