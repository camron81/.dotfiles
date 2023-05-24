local _2afile_2a = ".config/nvim/fnl/init.fnl"
local _2amodule_name_2a = "init"
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
local autoload = (require("aniseed.autoload")).autoload
local keymaps, nvim, options, plugins = autoload("config.keymaps"), autoload("aniseed.nvim"), autoload("config.options"), autoload("config.plugins")
do end (_2amodule_locals_2a)["keymaps"] = keymaps
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["options"] = options
_2amodule_locals_2a["plugins"] = plugins
nvim.ex.highlight("NormalFloat ctermbg=black guibg=black")
plugins.use("HiPhish/guile.vim", {}, "Olical/aniseed", {}, "Olical/conjure", {}, "gpanders/nvim-parinfer", {})
nvim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
nvim.g["conjure#client#guile#socket#pipename"] = "/home/ethan/guile.socket"
return _2amodule_2a