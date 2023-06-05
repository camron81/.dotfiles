local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format

local pack_path = fn.stdpath("data") .. "/site/pack"

function ensure (user, repo)
	local install_path = fmt("%s/packer/start/%s", pack_path, repo)
	if fn.empty(fn.glob(install_path)) > 0 then
		execute(fmt("!git clone https://github.com/%s/%s/ %s", user, repo, install_path))
		execute(fmt("packadd %s", repo))
	end
end

ensure("wbthomason", "packer.nvim")
ensure("Olical", "aniseed")
ensure("lewis6991", "impatient.nvim")

require("impatient")

vim.g["aniseed#env"] = {
	module = "config.core",
	compile = true
}
