(module config.mappings
  {autoload {c    config.core
             nvim aniseed.nvim}})
(import-macros {: plugin-loadable?} :macros)

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader " ")

(def- base-keymaps
  [[:n :<space> "<nop>"]
   [:i :<C-e> "<esc>"]
   ; File Mappings
   [:n :<leader>fq ":quit<cr>"]
   [:n :<leader>fQ ":quit!<cr>"]
   [:n :<leader>fs ":write<cr>"]
   [:n :<leader>fS ":write!<cr>"]
   ; Window Management
   [:n :<leader>wc ":close<cr>"]
   [:n :<leader>wm ":only<cr>"]
   [:n :<leader>wn ":new<cr>"]
   [:n :<leader>wq ":quit<cr>"]
   [:n :<leader>ws ":split<cr>"]
   [:n :<leader>wv ":vsplit<cr>"]
   ; Window Placement
   [:n :<leader>wh "<C-w><S-h>"]
   [:n :<leader>wj "<C-w><S-j>"]
   [:n :<leader>wk "<C-w><S-k>"]
   [:n :<leader>wl "<C-w><S-l>"]
   ; Window Navigation
   [:n :<C-h> "<C-w>h"]
   [:n :<C-j> "<C-w>j"]
   [:n :<C-k> "<C-w>k"]
   [:n :<C-l> "<C-w>l"]
   ; Window Resizing
   [:n :<C-Up> ":resize +2<cr>"]
   [:n :<C-Down> ":resize -2<cr>"]
   [:n :<C-Left> ":vertical resize -2<cr>"]
   [:n :<C-Right> ":vertical resize +2<cr>"]
   ; Buffer Management
   [:n :<leader>bm ":bmodified<cr>"]
   [:n :<leader>bn ":bnext<cr>"]
   [:n :<leader>bp ":bprevious<cr>"]
   [:n :<leader>bq ":bdelete<cr>"]
   ;Visual Mode
   [:v :< :<gv]
   [:v :> :>gv]
   [:v :<A-j> ":m .+2<cr>==gv"]
   [:v :<A-k> ":m .-2<cr>==gv"]
   [:v :p "_dP"]
   ; Terminal Mode
   [:n :<leader>tm ":terminal<cr>"]
   [:n :<leader>ts ":split  | :terminal<cr>"]
   [:n :<leader>tv ":vsplit | :terminal<cr>"]
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

(when (plugin-loadable? :telescope)
  (c.set-keymaps [[:n :<leader>ff ":Telescope find_files hidden=true<cr>"]
                  [:n :<leader>fr ":Telescope oldfiles hidden=true<cr>"]
                  [:n :<leader>bf ":Telescope buffers<cr>"]
                  [:n :<leader>sc ":Telescope commands<cr>"]
                  [:n :<leader>sf ":Telescope filetypes<cr>"]
                  [:n :<leader>sg ":Telescope live_grep<cr>"]
                  [:n :<leader>sk ":Telescope keymaps<cr>"]
                  [:n :<leader>sm ":Telescope man_pages sections=ALL<cr>"]
                  [:n :<leader>so ":Telescope vim_options<cr>"]
                  [:n :<leader>ss ":Telescope current_buffer_fuzzy_find<cr>"]
                  [:n :<leader>st ":Telescope treesitter<cr>"]]))
