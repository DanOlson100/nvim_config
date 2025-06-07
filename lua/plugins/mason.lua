-- Mason LSP and other Installer PlugIn
return {
    "mason-org/mason.nvim",

-- Setup Mason Options
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    },

-- Setup Mason
    config = function()
        require('mason').setup({})
    end,
}
