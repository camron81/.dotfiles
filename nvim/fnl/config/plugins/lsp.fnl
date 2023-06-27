(module config.plugins.lsp
  {autoload {lsp :lspconfig
             cmp :cmp_nvim_lsp}})

(def- path (.. (os.getenv "XDG_DATA_HOME") "/lsp-servers/"))

(let [capabilities (cmp.default_capabilities)]
  (lsp.bashls.setup 
    {:cmd [(.. path "bashls/node_modules/.bin/bash-language-server") "start"]
     :capabilities capabilities})
  (lsp.clangd.setup 
    {:capabilities capabilities}))
