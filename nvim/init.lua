vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'Olical/aniseed'
    use 'Olical/conjure'
end)

require('aniseed.env').init()
