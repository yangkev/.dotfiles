require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")

-- Override lsp mappings from nvchad 2.5 cause it's annoying
local map = vim.keymap.set

local function attach(client, bufnr)
    map("n", "gr", function()
        require("telescope.builtin").lsp_references()
    end)

    map("n", "<leader>rn", function()
        require("nvchad.lsp.renamer")()
    end)
    -- Hover documentation keymap
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

    -- Print diagnostics in floating window on cursor hold
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            vim.diagnostic.open_float(nil, { focus = false })
        end,
    })
end

-- lsps with default config
local servers = { "html", "cssls", "pyright", "terraformls" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    })
end

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    severity_sort = true,
    update_in_insert = true,
    float = {
        source = "always",
    },
})
