(module config.keymaps
  {autoload {nvim aniseed.nvim
             mapping lib.mapping}})

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader " ")

(let 
  [keymap-list 
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
    [:t :<C-l> "<C-\\><C-n><C-w>l"]]]
  (mapping.set-keymaps keymap-list))
