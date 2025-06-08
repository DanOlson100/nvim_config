-- Mason LSP Config
return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        "mason-org/mason.nvim",
        "nvim-lspconfig",
    },

-- Setup Mason-LSPConfig
-- The Servers are setup in nvim-lspconfig.lua
    config = function()

        -- Setup Mason-lspconfig
        require('mason-lspconfig').setup({
            ensure_installed = { 'bashls', 'lua_ls', 'pylsp' },
        })
    end,
}

