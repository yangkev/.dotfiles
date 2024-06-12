---@class ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
    theme = "everforest",
    theme_toggle = { "everforest", "one_light" },

    hl_override = highlights.override,
    hl_add = highlights.add,

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

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

return M
