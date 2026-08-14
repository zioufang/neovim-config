local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Remap space as leader key
-- Must be before lazy
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- default (nvim) = advanced profile, NVIM_APPNAME=nvim-min = core only
local is_min = vim.env.NVIM_APPNAME == "nvim-min"
local spec = { { import = "zi.plugins.core" } }
if not is_min then
  table.insert(spec, { import = "zi.plugins.advanced" })
end

require("lazy").setup({
  spec = spec,
  -- separate lockfiles so the profiles don't clobber each other's pins
  lockfile = vim.fn.stdpath("config") .. (is_min and "/lazy-lock-min.json" or "/lazy-lock.json"),
  defaults = { lazy = false },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = true, -- get a notification when changes are found
  },
  debug = false,
})
