(module config.plugins.lsp)
(import-macros {: safe-require : plugin-loadable?} :macros)

(def- path (.. (os.getenv "XDG_DATA_HOME") "/lsp-servers/"))

;; Consider Mappings
(let [lsp (safe-require :lspconfig)
      cmp (safe-require :cmp_nvim_lsp)
      capabilities (cmp.default_capabilities)]
  (lsp.bashls.setup 
    {:cmd [(.. path "bashls/node_modules/.bin/bash-language-server") "start"]
     :capabilities capabilities}))
