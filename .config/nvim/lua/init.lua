local _2afile_2a = ".config/nvim/fnl/init.fnl"
local _2amodule_name_2a = "config"
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
local nvim = require("aniseed.nvim")
do end (_2amodule_locals_2a)["nvim"] = nvim
nvim.g.maplocalleader = " "
nvim.ex.highlight("NormalFloat ctermbg=grey guibg=grey")
return _2amodule_2a