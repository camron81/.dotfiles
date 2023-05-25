(module config.keymaps
  {autoload {nvim aniseed.nvim}})

;; Local Leader
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

(let 
  [keymap-list 
   [[:n :<space> :<nop>]
    [:n :<leader>vw ":w<cr>"]
    [:n :<leader>vq ":q<cr>"]
    [:n :<leader>vwq ":wq<cr>"]
    [:n :<leader>e ":Lex 30<cr>"]
    [:n :<leader>E ":Ex<cr>"]
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
    ; New blank buffer...
    [:n :<leader>bn ":bnext<cr>"]
    [:n :<leader>bp ":bprevious<cr>"]
    [:n :<leader>bq ":bdelete!<cr>"]
    ;Visual Mode
    [:v :< :<gv]
    [:v :> :>gv]
    [:v :<A-j> ":m .+2<cr>==gv"]
    [:v :<A-k> ":m .-2<cr>==gv"]
    [:v :p "_dP"]]]
  
  (each [_ keymap (ipairs keymap-list)]
    (nvim.set_keymap (. keymap 1)
                     (. keymap 2)
                     (. keymap 3)
                     {:noremap true :silent true})))
