(module config.mappings
  {autoload {c    config.core
             nvim aniseed.nvim}})
(import-macros {: plugin-loadable?} :macros)

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader " ")

(def- base-keymaps
  [[:n :<space> :<nop>]
   [:i :<C-e> :<esc>]
   ; Window Navigation
   [:n :<C-h> :<C-w>h]
   [:n :<C-j> :<C-w>j]
   [:n :<C-k> :<C-w>k]
   [:n :<C-l> :<C-w>l]
   ; Window Resizing
   [:n :<C-Up> ":resize +2<cr>"]
   [:n :<C-Down> ":resize -2<cr>"]
   [:n :<C-Left> ":vertical resize -2<cr>"]
   [:n :<C-Right> ":vertical resize +2<cr>"]
   ;Visual Mode
   [:v :< :<gv]
   [:v :> :>gv]
   [:v :<A-j> ":m .+2<cr>==gv"]
   [:v :<A-k> ":m .-2<cr>==gv"]
   [:v :p "_dP"]
   ; Terminal Mode
   [:t :<esc> "<C-\\><C-n>"]
   [:t :<C-e> "<C-\\><C-n>"]
   [:t :<C-h> "<C-\\><C-n><C-w>h"]
   [:t :<C-j> "<C-\\><C-n><C-w>j"]
   [:t :<C-k> "<C-\\><C-n><C-w>k"]
   [:t :<C-l> "<C-\\><C-n><C-w>l"]])

(c.set-keymaps base-keymaps)

(when (plugin-loadable? :nvim-tree)
  (c.set-keymaps [[:n :<leader>fe ":NvimTreeToggle<cr>"]]))

(when (plugin-loadable? :packer)
  (c.set-keymaps [[:n :<leader>pc ":PackerClean<cr>"]
                  [:n :<leader>ps ":PackerSync<cr>"]
                  [:n :<leader>pS ":PackerStatus<cr>"]]))

   ; (which-key.register
   ;   {:f {:f ["<cmd>Telescope find_files hidden=true<cr>" "find files"]
   ;        :r ["<cmd>Telescope oldfiles hidden=true<cr>" "recent files"]}
   ;    :b {:f ["<cmd>Telescope buffers<cr>" "find buffers"]}
   ;    :s {:name "search"
   ;        :c ["<cmd>Telescope commands<cr>" "commands"]
   ;        :f ["<cmd>Telescope filetypes<cr>" "filetypes"]
   ;        :g ["<cmd>Telescope live_grep<cr>" "grep"]
   ;        :k ["<cmd>Telescope keymaps<cr>" "keymaps"]
   ;        :m ["<cmd>Telescope man_pages sections=ALL<cr>" "man pages"]
   ;        :o ["<cmd>Telescope vim_options<cr>" "vim options"]
   ;        :s ["<cmd>Telescope current_buffer_fuzzy_find<cr>" "search"]
   ;        :t ["<cmd>Telescope treesitter<cr>" "treesitter"]}}
   ;   {:prefix "<leader>"})))
