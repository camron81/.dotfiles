(module config.mappings
  {require {a    aniseed.core
            nvim aniseed.nvim}})

(defn set-keymaps! [keymap-table user-opts]
  (let [opts (if (a.nil? user-opts)
               {:noremap true :silent true}
               user-opts)]
    (each [_ mapping (ipairs keymap-table)]
      (nvim.set_keymap (. mapping 1)
                       (. mapping 2)
                       (. mapping 3)
                       opts))))

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

(set-keymaps! base-keymaps)
