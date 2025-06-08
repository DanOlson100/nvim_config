-- Nvim LSP configs
return {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },

    -- Options for LSP servers
    -- These are installed by mason-lspconfig
    opts = {
        servers = {
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    -- Add default global "vim" otherwise you get warnings in all vim configs
                    diagnostics = {
                        globals = { 'vim' }
                    },
                },
            },
            pylsp  = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = {'E122', 'E226', 'E252', 'E303', 'W391', 'E501', 'W504'},
                            maxLineLength = 200,
                        },
                    },
                },
            },
        }
    },

    -- Setup each LSP server
    config = function(_, opts)
        local status, lspconfig = pcall( require, 'lspconfig')
        if status then
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                vim.lsp.config[server] = { settings = config }
            end

            -- Setup some Diagnostic Keymaps
            vim.keymap.set('n', '[d',        vim.diagnostic.goto_prev,  { desc = "Go to previous diagnostic message" })
            vim.keymap.set('n', ']d',        vim.diagnostic.goto_next,  { desc = "Go to next diagnostic message" })
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
        end

    end,

    -- Example calling setup directly for each LSP
    --config = function()
    --    local capabilities = require('blink.cmp').get_lsp_capabilities()
    --    local lspconfig = require('lspconfig')
    --
    --    lspconfig['lua_ls'].setup({ capabilities = capabilities })
    --end
}

