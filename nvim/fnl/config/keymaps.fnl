(module config.keymaps
  {autoload {nvim aniseed.nvim}})

(defn- keymap [mode map cmd]
  (nvim.set_keymap mode map cmd {:noremap true}))

;; Local Leader
(keymap :n :<space> :<nop>)
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; Vim mappings
(keymap :n :<leader>vw ":w<cr>")
(keymap :n :<leader>vq ":q<cr>")
(keymap :n :<leader>vwq ":wq<cr>")
(keymap :i :<C-e> :<esc>)

;; Window Management
(keymap :n :<leader>wv :<C-w>v)
(keymap :n :<leader>ws :<C-w>s)
(keymap :n :<leader>wq :<C-w>q)
(keymap :n :<leader>wm ":only<cr>")

;; Window Navigation
(keymap :n :<C-h> :<C-w>h)
(keymap :n :<C-j> :<C-w>j)
(keymap :n :<C-k> :<C-w>k)
(keymap :n :<C-l> :<C-w>l)

;; Window Resizing
(keymap :n :<C-Up> ":resize +2<cr>")
(keymap :n :<C-Down> ":resize -2<cr>")
(keymap :n :<C-Left> ":vertical resize -2<cr>")
(keymap :n :<C-Right> ":vertical resize +2<cr>")

;; Buffer Management
(keymap :n :<leader>bn ":bnext<cr>")
(keymap :n :<leader>bp ":bprevious<cr>")
(keymap :n :<leader>bq ":bdelete!<cr>")
;;  New buffer...

;; Explore
(keymap :n :<leader>e ":Lex 30<cr>")

;; Visual Mode
(keymap :v :< :<gv)
(keymap :v :> :>gv)
(keymap :v :<A-j> ":m .+2<cr>==gv")
(keymap :v :<A-k> ":m .-2<cr>==gv")
(keymap :v :p "_dP")
