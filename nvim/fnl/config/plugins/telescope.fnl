(module config.plugins.telescope
  {autoload {nvim aniseed.nvim}})

(let [(ok? telescope) (pcall require :telescope)]
  (when ok?
    (let [actions (require :telescope.actions)]
      (telescope.setup
       {:defaults 
         {:prompt_prefix "  "
          :selection_caret "  "
          :path_display [:smart]
          :mappings {:i 
                     {:<esc> actions.close
                      :<C-e> actions.close
                      :<C-j> actions.move_selection_next
                      :<C-k> actions.move_selection_previous
                      :<Down> actions.move_selection_next
                      :<Up> actions.move_selection_previous
                      :<C-n> actions.cycle_history_next
                      :<C-p> actions.cycle_history_prev}}}})
    
      (let [keymap-list
             [[:n :<leader>fb ":Telescope buffers<cr>"]
              [:n :<leader>fc ":Telescope commands<cr>"]
              [:n :<leader>ff ":Telescope find_files hidden=true<cr>"]
              [:n :<leader>fg ":Telescope live_grep<cr>"]
              [:n :<leader>fk ":Telescope keymaps<cr>"]
              [:n :<leader>fm ":Telescope man_pages<cr>"]
              [:n :<leader>fo ":Telescope vim_options<cr>"]]]
        (each [_ keymap (ipairs keymap-list)]
          (nvim.set_keymap (. keymap 1)
                           (. keymap 2)
                           (. keymap 3)
                           {:noremap true :silent true}))))))
