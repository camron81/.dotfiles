(module config.plugins.treesitter)

(let [(ok? ts) (pcall require :nvim-treesitter.configs)]
  (if ok?
    (ts.setup
      {:ensure_installed ["bash" "ini" "janet_simple" "lua" "scheme"]
       :sync_install false
       :indent {:enable true
                :disable []}
       :highlight {:enable true
                   :disable []
                   :additional_vim_regex_highlighting true}})
    (print "config error: nvim-treesitter plugin could not be loaded")))
