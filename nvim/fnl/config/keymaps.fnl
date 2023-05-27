(module config.keymaps
  {autoload {nvim aniseed.nvim
             mapping lib.mapping}})

;; Local Leader
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

(let 
  [keymap-list 
   [[:n :<space> :<nop>]
    [:n :<leader>vq ":q<cr>"]
    [:n :<leader>vs ":w<cr>"]
    [:n :<leader>vwq ":wq<cr>"]
    [:i :<C-e> :<esc>]
    ; Window Management
    [:n :<leader>wv :<C-w>v]
    [:n :<leader>ws :<C-w>s]
    [:n :<leader>wq :<C-w>q]
    [:n :<leader>wm ":only<cr>"]
    ; Window Navigation
    [:n :<C-h> :<C-w>h]
    [:n :<C-j> :<C-w>j]
    [:n :<C-k> :<C-w>k]
    [:n :<C-l> :<C-w>l]
    ; Winow Resizing
    [:n :<C-Up> ":resize +2<cr>"]
    [:n :<C-Down> ":resize -2<cr>"]
    [:n :<C-Left> ":vertical resize -2<cr>"]
    [:n :<C-Right> ":vertical resize +2<cr>"]
    ; Buffer Management
    [:n :<leader>bn ":bnext<cr>"]
    [:n :<leader>bp ":bprevious<cr>"]
    [:n :<leader>bq ":bdelete!<cr>"]
    ; Packer Commands
    [:n :<leader>ps ":PackerSync<cr>"]
    ;Visual Mode
    [:v :< :<gv]
    [:v :> :>gv]
    [:v :<A-j> ":m .+2<cr>==gv"]
    [:v :<A-k> ":m .-2<cr>==gv"]
    [:v :p "_dP"]
    ; Terminal Mode
    [:n :<leader>ts ":split | :terminal<cr>"]
    [:n :<leader>tv ":vsplit | :terminal<cr>"]
    [:n :<leader><S-t> ":terminal<cr>"]
    [:t :<esc> "<C-\\><C-n>"]
    [:t :<C-e> "<C-\\><C-n>"]
    [:t :<C-h> "<C-\\><C-n><C-w>h"]
    [:t :<C-j> "<C-\\><C-n><C-w>j"]
    [:t :<C-k> "<C-\\><C-n><C-w>k"]
    [:t :<C-l> "<C-\\><C-n><C-w>l"]]]
  (mapping.set-keymaps keymap-list))
