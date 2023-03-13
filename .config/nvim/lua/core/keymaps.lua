-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- leader
vim.g.mapleader = ' '

-----------------------------------------------------------
-- shortcuts
-----------------------------------------------------------

-- Map Esc to jj
map('i', 'jj', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Fast saving 
map('n', '<C-s>', ':w<CR>')

-- Close 
map('n', '<C-q>', ':q<CR>')


-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------

---------------
-- nvim-tree 
---------------
map('n', '<C-b>', ':NvimTreeToggle<CR>')


---------------
-- Telescope 
---------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<C-f>', builtin.buffers, {})

---------------
-- Hop 
---------------
map('n', '<leader>h', ':HopWord<CR>')
