(module config.plugins.treesitter)

(let [(ok? ts) (pcall require :nvim-treesitter.configs)]
  (when ok?
   (ts.setup
     {:ensure_installed ["bash" "ini" "janet_simple" "lua" "scheme"]
      :sync_install false
      :indent {:enable true
               :disable []}
      :highlight {:enable true
                  :disable [ "fennel"]
                  :additional_vim_regex_highlighting true}})))
