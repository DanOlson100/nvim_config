-- Vim Basic Plugins
return {
    'ap/vim-css-color',            -- CSS color highlighter
    'chrisbra/vim-diff-enhanced',  -- Use GIT diff algorithms
    'equalsraf/neovim-gui-shim',   -- Neovim GUI Cmds
    'farmergreg/vim-lastplace',    -- Let vim goto the last edit position except commit msgs.
    'godlygeek/tabular',           -- For aligning text using :Tab /= or such
    'jreybert/vimagit',            -- Some git cmds added to Vim
    'kshenoy/vim-signature',       -- Shows marks and move between them
    'mbbill/undotree',             -- Visualize Undo as a Tree
    'preservim/vim-indent-guides', -- Indent Color guides
    'rickhowe/diffchar.vim',       -- Highlight only the Exact differences
    --'sheerun/vim-polyglot',        -- Various Syntax Files
    'tpope/vim-eunuch',            -- Various System commands
    'tpope/vim-fugitive',          -- Git in Vim
    'tpope/vim-surround',          -- Add/Remove Surrounding anything
    'vim-scripts/IndexedSearch',   -- Upgrade Search with status and location
    'wellle/context.vim',          -- Show only context funtion/loops/if - Similar to TreeSitter-Context for Nvim

    -- Settings
    config = function()

        -- DiffChar Settings
        local status, diff = pcall( require, "vim-diff-enhanced")
        if status then
            vim.g.DiffUnit = "Char"
            --vim.g.DiffUnit = "Word"
        end

        -- Toggle UndoTree
        local status, undo = pcall( require, "undotree")
        if status then
            vim.keymap.set( "n", "<leader>ut", "<Cmd>UndotreeToggle<CR>")
        end

        --Toggle Context
        local status, cont = pcall( require, "context")
        if status then
            vim.keymap.set( "n", "<leader>ct", "<Cmd>ContextToggle<CR>")
        end
    end,
}

