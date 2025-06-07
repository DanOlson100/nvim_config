-- Mason LSP Config
return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        "mason-org/mason.nvim",
        "nvim-lspconfig",
    },

-- Setup Mason-LSPConfig
    config = function()
        require('mason-lspconfig').setup({

            -- Enable the following language servers
            servers = {
                -- clangd = {},
                -- gopls = {},
                -- pyright = {},
                -- rust_analyzer = {},
                -- tsserver = {},

                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        -- Add default global "vim" otherwise you get warnings in all vim configs
                        diagnostics = {
                            globals = { "vim" }
                        },
                    },
                },
            },

--            ensure_installed = vim.tbl_keys(servers),
            ensure_installed = { servers },
        })
    end,
}

