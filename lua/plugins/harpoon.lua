-- Harpoon for Project Navigation  
return {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { 'nvim-lua/plenary.nvim' },

-- Setup Harpoon
    config = function()
        local status, harpoon = pcall(require, "harpoon")
        if status then

            -- Required
            harpoon:setup()

            -- Harpoon Keybindings
            vim.keymap.set( "n", "<leader>mf", function() harpoon:list():add() end,                          { desc = 'Harpoon Add File' } )
            vim.keymap.set( "n", "<leader>ff", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,  { desc = 'Harpoon Menu'     } )
            vim.keymap.set( "n", "<leader>nf", function() harpoon:list():next() end,                         { desc = 'Harpoon Next File'} )
            vim.keymap.set( "n", "<leader>pf", function() harpoon:list():prev() end,                         { desc = 'Harpoon Prev File'} )
        end
    end,
}

