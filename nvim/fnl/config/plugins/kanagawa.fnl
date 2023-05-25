(module config.plugins.kanagawa
  {autoload {nvim aniseed.nvim}})

(let [(ok? kanagawa) (pcall require :kanagawa)]
  (when ok?
    (kanagawa.load "dragon")))

