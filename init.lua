-- Dan's NeoVim Config
--
-- $Id: vimrc,v 1.12 2006/09/17 02:09:09 olson Exp $
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Plugin Setup                                 {{{
vim.loader.enable()

local HOME=os.getenv("HOME") or ""

--  Set <leader>, Must happen before plugins are loaded, otherwise wrong leader will be used
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Disable NetRW for Nvim-Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable some providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
--vim.g.loaded_perl_provider = 0
--vim.g.loaded_python3_provider = 0

-- Load Lazy Vim for Plugins
require("config.lazy")

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Various Functions                            {{{

-- Large File Support
local bigfile = 1024*1024
local aug = vim.api.nvim_create_augroup("buf_large", {clear = true})
vim.api.nvim_create_autocmd({"BufReadPre"}, {
    callback = function()
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
        if ok and stats and (stats.size > bigfile) then
            vim.b.large_bud = true
            --vim.opt.syntax = "off"
            --vim.cmd("IlluminatePauseBuf")
            --vim.cmd("IndentBlanklineDisable")
            vim.cmd("ContextDisable")
            vim.opt_local.foldmethod = "manual"
            vim.opt_local.spell = false
            vim.cmd("TSBufDisable autotag")
        else
            vim.b.large_buf = false
        end
    end,
    group = aug,
    pattern = "*",
})

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- General Options                              {{{
--vim.opt.filetype = "plugin"                         -- Load the filetype plugins
vim.opt.history = 100                                 -- How many lines of history to remember
vim.opt.cf = true                                     -- Enable error files and jumping
vim.opt.fileformats = "unix,dos,mac"                  -- Support these file systems
vim.opt.backup = false                                -- Don't Make Backup files
vim.opt.showcmd = true                                -- Show partial commands in the status line
vim.opt.modeline = false                              -- Security protection against trojan text files
vim.opt.title = false                                 -- Show filename in title bar

-- Neovim uses a different format for undo files
--  Only Neovim uses this file
vim.opt.undodir  = vim.fn.stdpath('data') .. "/undo-dir"   -- Set Undo file storage location
vim.opt.undofile = true                               -- Use Undo files to let undo work across exits

--}}} 
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Coloring                                     {{{
vim.opt.syntax = "on"                                 -- Turn on syntax highlighting
vim.opt.background = "dark"                           -- Try to use good colors
-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true                          -- Turn on True Colors if the Term support it

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Vim UI                                       {{{
vim.opt.linespace = 0                                 -- Space it out
vim.opt.ruler = true                                  -- Show current position
vim.opt.number = true                                 -- Show line numbers, use cor for relative numbers
vim.opt.relativenumber = true                         -- Show line numbers as relative numbers
vim.opt.backspace = "indent,eol,start"                -- Make Backspace work
vim.opt.errorbells = false                            -- Don't make noise
vim.opt.visualbell = false                            -- Don't Blink cursor
--vim.opt.whichwrap:prepend {"<,>,h,l,[,]"}             -- Backspace and cursor key wrap
vim.opt.startofline = false                           -- Don't jump to the first char when paging
vim.opt.scrolloff =  999                              -- Keep cursor x lines from the top/bottom
vim.opt.sidescrolloff = 999                           -- Keep cursor x columns in the middle when side scrolling
vim.opt.cursorline = true                             -- Use the color scheme for the current line and line Number
vim.opt.laststatus = 2                                -- Always show the status line as two lines
vim.opt.ttyfast = true                                -- Setup redraw for faster terminals
vim.opt.lazyredraw = true                             -- Don't redraw the screen when running macros
vim.opt.splitbelow = true                             -- When splitting horizontal put the new window below
vim.opt.splitright = true                             -- When splitting vertical put the new window to the right
vim.opt.mouse = 'a'                                   -- Enable Mouse mode
vim.opt.completeopt = 'menuone,noselect'              -- Show completion options in a menu

-- Use the Clipboard for P and yy
if vim.fn.has('clipboard') then
    if vim.fn.has('unnamedplus') then
        vim.opt.clipboard:prepend {"unnamedplus,unnamed"}
    else
        vim.opt.clipboard:prepend {"unnamed"}
    end
end

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Status Line                                  {{{
--
-- Get the git Branch w/ the Plugin vim-fugitive
-- But only do it an specific events
vim.b.git_status = ""
if ( vim.g.loaded_fugitive) then
    vim.api.nvim_create_augroup("gitstatusline", {clear = true})
    vim.api.nvim_create_autocmd( { "BufEnter", "FocusGained", "BufWritePost" }, {  callback = function() vim.b.git_status = vim.fn['fugitive#Head']() end, group = "gitstatusline" } )
end

-- These are also defined in the Molo Color Scheme
vim.cmd("hi User1 ctermbg=black  ctermfg=red        guibg=black  guifg=red")
vim.cmd("hi User2 ctermbg=red    ctermfg=DarkGreen  guibg=red    guifg=blue")
vim.cmd("hi User3 ctermbg=black  ctermfg=blue       guibg=black  guifg=blue")
vim.cmd("hi User4 ctermbg=black  ctermfg=magenta    guibg=black  guifg=magenta")
vim.cmd("hi User5 ctermbg=black  ctermfg=green      guibg=black  guifg=green")
vim.cmd("hi User6 ctermbg=black  ctermfg=yellow     guibg=black  guifg=yellow")

vim.cmd("set statusline=%1*[%3*%{toupper(mode())}%1*]")              --Show Mode
vim.cmd("set statusline+=[%4*%{get(b:,'git_status','')}%1*]")        --Show Git Branch
vim.cmd("set statusline+=[%5*%n%1*]")                                --Show Buffer #
vim.cmd("set statusline+=%F")                                        --Full Filename
vim.cmd("set statusline+=[%3*%M%1*")                                 --Modify Flag
vim.cmd("set statusline+=%2*%R%1*]")                                 --Read Only Flag
vim.cmd("set statusline+=%h")                                        --Help Flag
vim.cmd("set statusline+=%w")                                        --Show Preview if in Preview Window
vim.cmd("set statusline+=[%{&ff}]")                                  --File Format
vim.cmd("set statusline+=%y%3*")                                     --File Type
vim.cmd("set statusline+=%=")                                        --Right Align
vim.cmd("set statusline+=%1*[%L]")                                   --Total # of lines
vim.cmd("set statusline+=[%6*R%5*%5l%1*,%6*C%3*%5v%1*]")             --Current Line and Column #
vim.cmd("set statusline+=[%3p%%]")                                   --Percent through file

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Visual Cues                                  {{{
vim.opt.showmatch = true                              -- Show matching Brackets
vim.opt.matchtime = 5                                 -- 10th of seconds to blink matching brackets
vim.opt.hlsearch = true                               -- Highlight searched phrases
vim.opt.incsearch = true                              -- Highlight as you type searches
vim.opt.showmode = true                               -- Show vim's mode
vim.opt.ignorecase = true                             -- Ignore case when searching
vim.opt.smartcase = true                              -- Use case when searching using upper case chars
vim.opt.inccommand = "split"                          -- Show window split with searched terms

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Text Formatting/Layout                       {{{
--set formatoptions=tcrqn                             -- Format Option t=autowrap text, c=autowrap comments & auto insert after enter
--                                                    -- q=allow formatting with qq, n=reorganize numbered list
vim.opt.smartindent = true                            -- Turn on smart indenting
--filetype plugin indent on                           -- Turn on the plugin indent
vim.opt.tabstop = 4                                   -- Number of spaces to represent a Tab
vim.opt.shiftwidth = 4                                -- Number of spaces to use for each step of auto-indent
vim.opt.softtabstop = 4                               -- Remove 4 spaces with one backspace
vim.opt.expandtab = true                              -- Insert spaces instead of tabs
vim.opt.wrap = false                                  -- Don't wrap lines
vim.opt.shiftround = true                             -- Round indent to multiple of shiftwidth
vim.opt.breakindent = true                            -- Indent w/ line cont characters


--Change invisible characters: tab, end-of-line, spaces
--vim.opt.list = true
--vim.opt.lcs  = "tab:┠-,eol:¬,trail:·,extends:»,precedes:«"           --Show symbol for End of Line and Tabs

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Difference Options                           {{{

--See above in Coloring for color diff settings
-- Setup NeoVim Diff
vim.opt.diffopt:append { "internal,algorithm:patience" }
--let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Wild Menu                                    {{{
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.wildignore:append { ".hg,.git,.svn" }              -- Ignore version control files
vim.opt.wildignore:append { "*.jpeg,*.jpg,*.bmp,*.png" }   -- Ignore binary picture files
vim.opt.wildignore:append { "*.o,*.obj,*.exe,*.dll" }      -- Ignore compiled object files
vim.opt.wildignore:append { "*.sw?" }                      -- Ignore vim swap files

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Folding                                      {{{
vim.opt.foldmethod = "marker"
vim.opt.foldlevelstart = 0

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Filetypes                                    {{{
--  Load before Keymaps as some depend on Filetypes

-- Add Helper lines for Git Commit Mesages
vim.api.nvim_create_augroup("gitcommit", {clear = true})
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"gitcommit"}, callback = function() vim.opt.textwidth=72 vim.opt.colorcolumn="51,73" end, group = "gitcommit" } )

-- Load filetypes.vim if it exists
if vim.uv.fs_stat( HOME .. "/.vim/filetypes.vim") then
    vim.cmd( "source" .. HOME .. "/.vim/filetypes.vim")
elseif vim.uv.fs_stat( HOME .. "/vimfiles/filetypes.vim") then
    vim.cmd( "source" .. HOME .. "/vimfiles/filetypes.vim")
end
--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Key Mappings                                 {{{

-- Map new goto start and end keys
vim.keymap.set( {"n", "v"}, "H", "0")
vim.keymap.set( {"n", "v"}, "L", "$")

-- Map ii to <Escape>
vim.keymap.set( {"n", "i", "v"}, "ii", "<Esc>")

-- Map jj to <Escape>
--vim.keymap.set( {"n", "i", "v"}, "jj", "<Esc>")

-- Map vv to <Ctrl>v to use when terminal has Paste
vim.keymap.set("n", "vv", "<C-v>")

-- Use Space to toggle folds
vim.keymap.set( {"n", "v"}, "<Space>", "za")

-- Don't use the Arrow Keys
-- vim.keymap.set( "n", "<Up>",    "<NOP>")
-- vim.keymap.set( "n", "<Down>",  "<NOP>")
-- vim.keymap.set( "n", "<Left>",  "<NOP>")
-- vim.keymap.set( "n", "<Right>", "<NOP>")
-- vim.keymap.set( "i", "<Up>",    "<NOP>")
-- vim.keymap.set( "i", "<Down>",  "<NOP>")
-- vim.keymap.set( "i", "<Left>",  "<NOP>")
-- vim.keymap.set( "i", "<Right>", "<NOP>")

-- Move in Insert and Cmd (Dont Work)
vim.keymap.set( {"i", "c"}, "C-h>", "<Left>")
vim.keymap.set( {"i", "c"}, "C-j>", "<Down>")
vim.keymap.set( {"i", "c"}, "C-k>", "<Up>")
vim.keymap.set( {"i", "c"}, "C-l>", "<Right>")

-- Map Ctrl b or f to Page Down/Up
--  These are innate to vim
vim.keymap.set( "n", "<C-f>", "<PageDown>")
vim.keymap.set( "n", "<C-b>", "<PageUp>")

-- Switch Splits
--vim.keymap.set( "n", "ww", "<C-w><C-w>")
vim.keymap.set( "n", "qq", "<C-w><C-w>")

-- Buffer Commands
-- :b1 - move to buffer 1
vim.keymap.set( "n", "<leader>bn", "<Cmd>bnext<Cr>")
vim.keymap.set( "n", "<leader>bp", "<Cmd>bprevious<Cr>")

-- Correct Wq
vim.cmd( "cnoreabbrev Wq wq")

-- Correct Q
--cnoreabbrev Q q

-- Map Ctrl-u to Uppercase the current word
vim.keymap.set( {"n"}, "<C-u>", "gUaw")

-- Map Ctrl-l to Lowercase the current word
vim.keymap.set( {"n"}, "<C-l>", "guaw")

-- Edit my Vim file
vim.keymap.set( "n", "<leader>ev", ":vsplit $MYVIMRC<Cr>")

-- Source my Vim file
vim.keymap.set( "n", "<leader>sv", ":source $MYVIMRC<Cr>")

-- Map ff over word to find and replace
--vim.keymap.set( "n", "ff", ":%s/<C-r>=expand(\"<cword>\")<CR>\>/")

-- Move a visual selection up/down
vim.keymap.set( "v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set( "v", "K", ":m '<-2<CR>gv=gv")

-- Move a single line up/down
vim.keymap.set( "n", "<leader>k", ":m .-2<CR>==")
vim.keymap.set( "n", "<leader>j", ":m .+1<CR>==")

-- Clear Search highlights with Ctrl s
vim.keymap.set( "n", "<C-s>", function() vim.cmd("noh") end )

-- Yank from cursor to end of line excluding \n
vim.keymap.set( "n", "Y", "y$")

-- Join Lines but don't move cursor posiions
vim.keymap.set( "n", "<leader>J", "moJ`o")

-- Duplicate line at the end
vim.keymap.set( "n", "<leader>y", "yypkJ")

-- Shortcut split and vsplit
vim.keymap.set( "n", "<leader>s", "<Cmd>split<CR>")
vim.keymap.set( "n", "<leader>v", "<Cmd>vsplit<CR>")

-- Add Undo Break Points
vim.keymap.set( "i", ",", ",<C-g>u")
vim.keymap.set( "i", ".", ".<C-g>u")
vim.keymap.set( "i", "!", "!<C-g>u")
vim.keymap.set( "i", "?", "?<C-g>u")
vim.keymap.set( "i", ":", ":<C-g>u")
vim.keymap.set( "i", "(", "(<C-g>u")
vim.keymap.set( "i", "[", "[<C-g>u")
vim.keymap.set( "i", "{", "{<C-g>u")
vim.keymap.set( "i", ")", ")<C-g>u")
vim.keymap.set( "i", "]", "]<C-g>u")
vim.keymap.set( "i", "}", "}<C-g>u")

-- Various Commands
--   Neovim doesn't have <silent>
--   col = Toggle list and show tab/EOL and other chars
--   con = Toggle line number display
--   cor = Toggle relative number display
--   cos = Toggle spell checking
--   cow = Toggle line wrapping
--   ccl = Toggle a diff color on the cursor row
--   ccc = Toggle a diff color on the cursor column
vim.keymap.set( "n", "col", function() vim.cmd("set list!") end )
vim.keymap.set( "n", "con", function() vim.cmd("set number!") end )
vim.keymap.set( "n", "cor", function() vim.cmd("set relativenumber!") end )
vim.keymap.set( "n", "cos", function() vim.cmd("set spell!") end )
vim.keymap.set( "n", "cow", function() vim.cmd("set wrap!") end )
vim.keymap.set( "n", "ccl", function() vim.cmd("set cursorline!") end )
vim.keymap.set( "n", "ccc", function() vim.cmd("set cursorcolumn!") end )

-- Add Comments with <leader>c , remove with <leader>z
vim.api.nvim_create_augroup( "comments", { clear = true})
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"vim"},                    callback = function() vim.keymap.set("n", "<leader>c", "mogI\"<ESC>`odmo") end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"lua"},                    callback = function() vim.keymap.set("n", "<leader>c", "mogI--<ESC>`odmo") end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"sh","bash","csh","perl"}, callback = function() vim.keymap.set("n", "<leader>c", "mogI#<ESC>`odmo")  end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"yaml","python", "conf"},  callback = function() vim.keymap.set("n", "<leader>c", "mogI#<ESC>`odmo")  end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"cpp","c"},                callback = function() vim.keymap.set("n", "<leader>c", "mogI//<ESC>`odmo") end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"skill"},                  callback = function() vim.keymap.set("n", "<leader>c", "mogI;<ESC>`odmo")  end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"spice"},                  callback = function() vim.keymap.set("n", "<leader>c", "mogI*<ESC>`odmo")  end, group = "comments" } )

vim.api.nvim_create_autocmd( "FileType", { pattern =  {"vim"},                    callback = function() vim.keymap.set("n", "<leader>z", 'mo<CMD>s/"//<CR><CMD>nohlsearch<CR>`odmo')  end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"lua"},                    callback = function() vim.keymap.set("n", "<leader>z", 'mo<CMD>s/--//<CR><CMD>nohlsearch<CR>`odmo') end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"sh","bash","csh","perl"}, callback = function() vim.keymap.set("n", "<leader>z", 'mo<CMD>s/#//<CR><CMD>nohlsearch<CR>`odmo')  end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"yaml","python"},          callback = function() vim.keymap.set("n", "<leader>z", 'mo<CMD>s/#//<CR><CMD>nohlsearch<CR>`odmo')  end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"cpp","c"},                callback = function() vim.keymap.set("n", "<leader>z", 'mo<CMD>s/////<CR><CMD>nohlsearch<CR>`odmo') end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"skill"},                  callback = function() vim.keymap.set("n", "<leader>z", 'mo<CMD>s/;//<CR><CMD>nohlsearch<CR>`odmo')  end, group = "comments" } )
vim.api.nvim_create_autocmd( "FileType", { pattern =  {"spice"},                  callback = function() vim.keymap.set("n", "<leader>z", 'mo<CMD>s/*//<CR><CMD>nohlsearch<CR>`odmo')  end, group = "comments" } )

--}}}
--"""""""""""""""""""""""""""""""""""""""""""""""""
-- Set the Color Last                           {{{

-- Set the Color Scheme one more Time
-- as some Plugin is overwritting the
-- colors...
if ( vim.g.loaded_molo == 1 ) then
    vim.cmd.colorscheme 'molo'
end


--}}}

