nnoremap <s-k> 5k
nnoremap <s-j> 5j
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

nnoremap <leader>m :lua require('harpoon.mark').add_file()<CR>
nnoremap <leader>pl :Telescope harpoon marks<CR>
nnoremap <leader>pp :lua require('harpoon.ui').nav_file(1)<CR>
