(module config.plugins.telescope
  {autoload {telescope :telescope
             actions   :telescope.actions}})

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
                   :<C-n> actions.cycle_history_next
                   :<C-p> actions.cycle_history_prev}}}})
