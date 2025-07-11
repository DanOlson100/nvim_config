-- Telescope Fuzzy Finder and dependencies
return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        { 'nvim-telescope/telescope-fzf-native.nvim', build='make'},
    },

-- Configure Telescope
    config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    }
                }
            }
        }
    end,

-- More Setup
    init = function()
        local status, tele = pcall( require, 'telescope')
        if status then
            -- Enable telescope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')

            -- Setup Keymaps for Telescope
            vim.keymap.set('n', '<leader>sf',      require('telescope.builtin').find_files,  { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh',      require('telescope.builtin').help_tags,   { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw',      require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg',      require('telescope.builtin').live_grep,   { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd',      require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
            --vim.keymap.set('n', '<leader>?',       require('telescope.builtin').oldfiles,    { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,     { desc = '[ ] Find existing buffers' })
            --vim.keymap.set('n', '<leader>/', function()
            --    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            --        winblend = 10,
            --        previewer = false,
            --    })
            --end, { desc = '[/] Fuzzily search in current buffer' })
        end
    end,
}

