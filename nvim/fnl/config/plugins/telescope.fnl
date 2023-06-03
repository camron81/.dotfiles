(module config.plugins.telescope
  {autoload {nvim aniseed.nvim}})

(defn- safe-require [module-name]
  (let [(ok? mod) (pcall require module-name)]
    (if ok? mod nil)))

(def- modules
  [(safe-require :telescope)
   (safe-require :which-key)])

(match modules
  [nil _] (print "nvim-tree: failed to load telescope plugin")
  [_ nil] (print "nvim-tree: failed to load which-key plugin")
  
  [telescope which-key]
  (do
    (telescope.setup
      (let [actions (require :telescope.actions)]
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
                       :<C-p> actions.cycle_history_prev}}}}))
    
    (which-key.register
      {:f {:f ["<cmd>Telescope find_files hidden=true<cr>" "find files"]
           :r ["<cmd>Telescope oldfiles hidden=true<cr>" "recent files"]}
       :b {:f ["<cmd>Telescope buffers<cr>" "find buffers"]}
       :s {:name "search"
           :c ["<cmd>Telescope commands<cr>" "commands"]
           :f ["<cmd>Telescope filetypes<cr>" "filetypes"]
           :g ["<cmd>Telescope live_grep<cr>" "grep"]
           :k ["<cmd>Telescope keymaps<cr>" "keymaps"]
           :m ["<cmd>Telescope man_pages sections=ALL<cr>" "man pages"]
           :o ["<cmd>Telescope vim_options<cr>" "vim options"]
           :s ["<cmd>Telescope current_buffer_fuzzy_find<cr>" "search"]
           :t ["<cmd>Telescope treesitter<cr>" "treesitter"]}}
      {:prefix "<leader>"})))
