-- Blink.cmp Completion Plug-in
return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'super-tab' },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'Hack Nerd Font Mono'
        },

        completion = {
            menu = {
                auto_show = function(ctx) return ctx.mode ~= "cmdline" end,
                border = "rounded",
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",

                draw = {
                    columns = { { "label", "label_description", gap = 1 }, { "kind", gap = 1, "kind_icon" }},
                },

            },


            -- Show the documentation popup automatically for selection
            documentation = { 

                auto_show =  true,

                window = { border = "rounded",},
            }
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' , 'omni' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        fuzzy = { implementation = "prefer_rust_with_warning" },

        -- For the cmdline in neovim auto show the selections and use the same keymap as editing.
        cmdline = {
            keymap = { preset = "inherit" },

            -- Don't Auto Show the Menu Use, <C-Space>
            -- This allows the use of up/down arrows for history
            --completion = { menu = { auto_show = true } },
        },
    },
    opts_extend = { "sources.default" }
}

