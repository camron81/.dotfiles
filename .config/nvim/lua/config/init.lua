local _2afile_2a = ".config/nvim/fnl/config/init.fnl"
local _2amodule_name_2a = "config.init"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local nvim, plugin = require("aniseed.nvim"), require("config.plugin")
do end (_2amodule_locals_2a)["nvim"] = nvim
_2amodule_locals_2a["plugin"] = plugin
nvim.g.mapleader = " "
nvim.g.maplocalleader = ","
nvim.ex.highlight("NormalFloat ctermbg=grey guibg=grey")
plugin.use("HiPhish/guile.vim", {}, "Olical/aniseed", {}, "Olical/conjure", {}, "gpanders/nvim-parinfer", {})
nvim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
nvim.g["conjure#client#guile#socket#pipename"] = "/home/ethan/guile.socket"
return _2amodule_2a