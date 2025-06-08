-- Indent Guides
return {
    'lukas-reineke/indent-blankline.nvim',
    enabled = true,
    main = "ibl",
    opts = {
        --indent = { char = "|" },
        debounce = 50,
        scope = { enabled = false},
        exclude = { 
            filetypes = { 'help',     'packer', 'nvimtree', 'dashboard', 'neo-tree' },
            buftypes  = { 'terminal', 'nofile', 'quickfix' },
        },
    },

-- Setup Indent Guides
    config = function(_, opts)
        require("ibl").setup( opts)

        -- Toggle IndentGuides
        vim.keymap.set( "n", "<leader>ig", "<Cmd>IBLToggle<CR>")
    end,
}

