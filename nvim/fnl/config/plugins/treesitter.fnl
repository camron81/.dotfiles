(module config.plugins.treesitter
  {autoload {ts :nvim-treesitter.configs}})

(ts.setup
  {:ensure_installed 
   ["bash" 
    "c"
    "ini" 
    "janet_simple" 
    "lua" 
    "make"
    "scheme" 
    "vimdoc"]
   :sync_install false
   :indent {:enable true
            :disable []}
   :highlight {:enable true
               :disable []
               :additional_vim_regex_highlighting true}})
