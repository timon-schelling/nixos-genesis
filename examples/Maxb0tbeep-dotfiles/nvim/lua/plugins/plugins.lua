-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },

  { "nyoom-engineering/oxocarbon.nvim" },

  {
    "gen740/SmoothCursor.nvim",
    config = function()
      return require("plugins.config.smoothcursor")
    end,
  },

  {
    "andweeb/presence.nvim",
    config = function()
      return require("presence").setup({})
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      return require("plugins.config.dashboard")
    end,
  },

  { "lambdalisue/suda.vim" },
}
