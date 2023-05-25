;(module config.plugins.treesitter
;  {autoload {nvim aniseed.nvim}}
;
;(let [(ok? ts) (pcall require :nvim-treesutter.configs)]
;  (when ok?
;    (ts.setup
;      {:ensure_installed ["fennel" "ini" "janet_simple" "lua" "scheme"]
;       :sync_install false
;       :indent {:enable true}
;       :highlight {:enable true
;                   :additional_vim_regex_highlighting true}})))
