-- Ctrl+h/j/k/l inside Snacks explorer and picker windows: same split -> Herdr pane navigation
-- as the global keymaps (see lua/config/mux_nav.lua), while keeping Insert-mode Ctrl+j/k/h
-- intact inside fuzzy-finder prompt inputs.
local navigate = require("config.mux_nav").navigate

local nav_keys = {
  ["<c-h>"] = { navigate("h"), mode = { "n" }, desc = "Navigate Left (Split/Pane)" },
  ["<c-j>"] = { navigate("j"), mode = { "n" }, desc = "Navigate Down (Split/Pane)" },
  ["<c-k>"] = { navigate("k"), mode = { "n" }, desc = "Navigate Up (Split/Pane)" },
  ["<c-l>"] = { navigate("l"), mode = { "n" }, desc = "Navigate Right (Split/Pane)" },
}

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<c-h>"] = { navigate("h"), mode = { "n" }, desc = "Navigate Left (Split/Pane)" },
              ["<c-l>"] = { navigate("l"), mode = { "n" }, desc = "Navigate Right (Split/Pane)" },
            },
          },
          list = { keys = vim.deepcopy(nav_keys) },
          preview = { keys = vim.deepcopy(nav_keys) },
        },
      },
    },
  },
}
