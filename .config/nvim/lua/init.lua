-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
-- TODO: Move keymaps from configs to lazy
require("lazy").setup("plugins", { -- opts
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  checker = { enabled = false }, -- check for plugin updates
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- lockfile generated after running update.
})
