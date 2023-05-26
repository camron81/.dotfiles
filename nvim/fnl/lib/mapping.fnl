(module lib.mapping
  {autoload {nvim aniseed.nvim}})

(defn set-keymaps [keymap-list]
  (each [_ keymap (ipairs keymap-list)]
    (nvim.set_keymap (. keymap 1)
                     (. keymap 2)
                     (. keymap 3)
                     {:noremap true :silent true})))
