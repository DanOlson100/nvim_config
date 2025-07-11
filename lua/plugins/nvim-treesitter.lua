-- Tree Sitter Plugin and dependencies for language parsing
return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    --config = function()
    --    pcall(require('nvim-treesitter.install').update { with_sync = true })
    --end,

    -- Add languages to be installed here that you want installed for treesitter
    --ensure_installed = { 'bash', 'c', 'cpp', 'go', 'lua', 'perl', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },
    ensure_installed   = { 'bash', 'lua', 'perl', 'python', 'vimdoc', 'vim'},

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    --highlight = { enable = true, disable = function(){ return vim.b.large_buf } },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

--    -- Setup the LSP
--    local on_attach = function(_, bufnr)
--        local nmap = function(keys, func, desc)
--            if desc then
--                desc = 'LSP: ' .. desc
--            end
--            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--        end
--
--        nmap('<leader>rn', vim.lsp.buf.rename,                                         '[R]e[n]ame')
--        nmap('<leader>ca', vim.lsp.buf.code_action,                                    '[C]ode [A]ction')
--        nmap('gd',         vim.lsp.buf.definition,                                     '[G]oto [D]efinition')
--        nmap('gr',         require('telescope.builtin').lsp_references,                '[G]oto [R]eferences')
--        nmap('gI',         vim.lsp.buf.implementation,                                 '[G]oto [I]mplementation')
--        nmap('<leader>D',  vim.lsp.buf.type_definition,                                'Type [D]efinition')
--        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,          '[D]ocument [S]ymbols')
--        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--        nmap('K',          vim.lsp.buf.hover,                                          'Hover Documentation')
--        nmap('<C-k>',      vim.lsp.buf.signature_help,                                 'Signature Documentation')
--        nmap('gD',         vim.lsp.buf.declaration,                                    '[G]oto [D]eclaration')
--        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder,                           '[W]orkspace [A]dd Folder')
--        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder,                        '[W]orkspace [R]emove Folder')
--        nmap('<leader>wl', function()
--            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--        end, '[W]orkspace [L]ist Folders')
--
--        -- Create a command `:Format` local to the LSP buffer
--        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--            vim.lsp.buf.format()
--        end, { desc = 'Format current buffer with LSP' })
--    end
--
--    -- Enable the following language servers
--    local servers = {
--        -- clangd = {},
--        -- gopls = {},
--        -- pyright = {},
--        -- rust_analyzer = {},
--        -- tsserver = {},
--
--        lua_ls = {
--            Lua = {
--                workspace = { checkThirdParty = false },
--                telemetry = { enable = false },
--                -- Add default global "vim" otherwise you get warnings in all vim configs
--                diagnostics = {
--                    globals = { "vim" }
--                },
--            },
--        },
--    }

