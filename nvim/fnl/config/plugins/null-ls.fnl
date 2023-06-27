(module config.plugins.null-ls
  {autoload {null-ls :null-ls}})

(let [actions     null-ls.builtins.code_actions
      diagnostics null-ls.builtins.diagnostics
      formatting  null-ls.builtins.formatting
      hover       null-ls.builtins.hover
      completion  null-ls.builtins.completion]
  (null-ls.setup 
    {:sources [; Bash
               actions.shellcheck
               diagnostics.shellcheck
               formatting.shfmt
               ; C
               diagnostics.clang_check
               formatting.clang_format]}))
