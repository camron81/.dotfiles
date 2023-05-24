local _2afile_2a = ".config/nvim/fnl/config/keymaps.fnl"
local _2amodule_name_2a = "config.keymaps"
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
local nvim = autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["nvim"] = nvim
local function keymap(mode, map, cmd)
  return nvim.set_keymap(mode, map, cmd, {noremap = true})
end
_2amodule_locals_2a["keymap"] = keymap
keymap("n", "<space>", "<nop>")
nvim.g.mapleader = " "
nvim.g.maplocalleader = ","
keymap("n", "<leader>vw", ":w<cr>")
keymap("n", "<leader>vq", ":q<cr>")
keymap("n", "<leader>vwq", ":wq<cr>")
keymap("i", "<C-e>", "<esc>")
keymap("n", "<leader>wv", "<C-w>v")
keymap("n", "<leader>ws", "<C-w>s")
keymap("n", "<leader>wq", "<C-w>q")
keymap("n", "<leader>wm", ":only<cr>")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-Up>", ":resize +2<cr>")
keymap("n", "<C-Down>", ":resize -2<cr>")
keymap("n", "<C-Left>", ":vertical resize -2<cr>")
keymap("n", "<C-Right>", ":vertical resize +2<cr>")
keymap("n", "<leader>bn", ":bnext<cr>")
keymap("n", "<leader>bp", ":bprevious<cr>")
keymap("n", "<leader>bq", ":bdelete!<cr>")
keymap("n", "<leader>e", ":Lex 30<cr>")
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("v", "<A-j>", ":m .+2<cr>==gv")
keymap("v", "<A-k>", ":m .-2<cr>==gv")
keymap("v", "p", "_dP")
return _2amodule_2a