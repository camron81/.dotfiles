(module config.plugins.null-ls)
(import-macros {: safe-require} :macros)

(let [null-ls     (safe-require :null-ls)
      actions     null-ls.builtins.code_actions
      diagnostics null-ls.builtins.diagnostics
      formatting  null-ls.builtins.formatting
      hover       null-ls.builtins.hover
      completion  null-ls.builtins.completion]
  (null-ls.setup 
    {:sources [; Bash
               actions.shellcheck
               diagnostics.shellcheck]}))
               ;formatting.shfmt
