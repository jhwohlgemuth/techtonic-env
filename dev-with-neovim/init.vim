source ~/AppData/Local/nvim/general/settings.vim
source ~/AppData/Local/nvim/general/plugins.vim
source ~/AppData/Local/nvim/plug-config/coc.vim
source ~/AppData/Local/nvim/plug-config/fzf.vim
source ~/AppData/Local/nvim/plug-config/which-key.vim
source ~/AppData/Local/nvim/themes/onedark.vim

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" {{ Keymappings }}
let g:mapleader = "\<Space>"
nnoremap <silent> <C-s> :w<CR>
" use <CR> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" Exit terminal with Escape
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <C-Bslash> :CocCommand explorer --toggle<CR>
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
" map <C-f> :Files<CR>
" map <leader>b :Buffers<CR>
" nnoremap <leader>g :Rg<CR>
" nnoremap <leader>t :Tags<CR>
" nnoremap <leader>m :Marks<CR>