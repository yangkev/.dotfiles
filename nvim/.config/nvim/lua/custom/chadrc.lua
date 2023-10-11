---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
    theme = "everforest",
    theme_toggle = { "everforest", "one_light" },

    hl_override = highlights.override,
    hl_add = highlights.add,

    tabufline = {
        enabled = false,
    },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

-- Enable netrw for :GBrowse
-- https://github.com/NvChad/NvChad/issues/2032#issuecomment-1551002296
M.lazy_nvim = {
    performance = {
        rtp = {
            disabled_plugins = vim.tbl_filter(function(name)
                return string.sub(name, 1, 5) ~= "netrw"
            end, require("plugins.configs.lazy_nvim").performance.rtp.disabled_plugins),
        },
    },
}

return M
