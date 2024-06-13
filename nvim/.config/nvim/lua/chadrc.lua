-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
    theme = "everforest",

    statusline = {
        overriden_modules = function(modules)
            -- table.remove(modules, 10)
            table.remove(modules, 8)
            table.remove(modules, 7)
            table.remove(modules, 6)
            table.remove(modules, 5)

            table.insert(
                modules,
                5,
                (function()
                    return "%m "
                end)()
            )
        end,
    },

    tabufline = {
        enabled = false,
    },
}

return M
