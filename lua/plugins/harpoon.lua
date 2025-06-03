-- Harpoon for Project Navigation  
return {
    { 'ThePrimeagen/harpoon',
        branch = "harpoon2",
        dependencies = { 'nvim-lua/plenary.nvim' },

-- Setup Harpoon
        config = function()
            require("harpoon").setup {
                global_settings = {
                    save_on_toggle = false,
                    save_on_change = true,
                    enter_on_sendcmd = false,
                    tmux_autoclose_windows = false,
                    excluded_filetypes = { "harpoon" },
                    mark_branch = false,
                },
            }
        end,
    }
}

