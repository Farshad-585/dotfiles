-- Ctrl+h/j/k/l: move between Neovim splits, and at the edge hand focus to the neighbouring
-- Herdr pane (`herdr pane focus`). Herdr's side is ~/.config/herdr/scripts/navigate.sh,
-- which passes Ctrl+h/j/k/l to Neovim when Neovim runs in the focused pane.
local M = {}

local herdr_dirs = { h = "left", j = "down", k = "up", l = "right" }

-- Moves to the neighbouring split; true when there is none in that direction.
local function at_edge(direction)
  local win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. direction)
  return vim.api.nvim_get_current_win() == win
end

function M.navigate(direction)
  return function()
    if vim.api.nvim_get_mode().mode == "t" then
      vim.cmd("stopinsert")
    end
    if not at_edge(direction) then
      return
    end
    if vim.env.HERDR_ENV == "1" and vim.env.HERDR_PANE_ID then
      -- HERDR_BIN_PATH may resolve into a versioned Cellar directory that `brew upgrade` removes.
      local herdr = vim.env.HERDR_BIN_PATH
      if not herdr or vim.fn.executable(herdr) == 0 then
        herdr = "/opt/homebrew/bin/herdr"
      end
      if vim.fn.executable(herdr) == 0 then
        herdr = "herdr"
      end
      vim.fn.jobstart({
        herdr,
        "pane", "focus", "--direction", herdr_dirs[direction], "--pane", vim.env.HERDR_PANE_ID,
      })
    end
  end
end

return M
