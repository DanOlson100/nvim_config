-- YAML/JSON Key Display
return {
    { 'jfryy/keytrail.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-telescope/telescope.nvim',
        },

-- Serup Key Trail's Display
        config = function()
            require("keytrail").setup()
        end,
    },
}
