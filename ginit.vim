" Dan's neovim-qt Config File

" Enable Mouse
set mouse=a

" Download fonts from Nerd Fonts
" Use curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/hack.zip
" Copy and extract to ~/.local/share/fonts/
" Use 'fc-cache -v ~/.local/share/fonts/' to add it to the cache
" Use 'fc-list <name>' to list out the font

"" Set Editor Font
if exists(':GuiFont')
    "Use GuiFont! to ignore font errors
    "GuiFont {font_name}:h{size}
    GuiFont! Hack Nerd Font Mono:h12
endif

" Adjust the GUI to use the Neovim colorscheme
if exists(':GuiAdaptiveColor')
    GuiAdaptiveColor 1
endif

" Adjust the GUI to use Qt Styles
if exists(':GuiAdaptiveStyle')
    GuiAdaptiveStyle fusion
endif

" Enable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 1
endif

" Enable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 1
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

