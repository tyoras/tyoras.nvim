-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Escape
vim.keymap.set({ 'i', 'v' }, 'jk', '<Esc>', { desc = 'Escape' })
vim.keymap.set({ 'i', 'v' }, 'kj', '<Esc>', { desc = 'Escape' })
vim.keymap.set('n', '<C-c>', '<Esc>', { desc = 'Escape' })

-- Save & Quit
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save buffer' })
vim.keymap.set('n', '<C-q>', ':wq!<CR>', { desc = 'Save and quit buffer' })

-- Buffer navigation
vim.keymap.set('n', '<TAB>', ':bnext<CR>', { desc = 'Move to next buffer' })
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', { desc = 'Move to previous buffer' })

-- Use alt + hjkl to resize windows
vim.keymap.set('n', '<M-j>', ':resize -2<CR>', { desc = 'Reduce windows horizontal size' })
vim.keymap.set('n', '<M-k>', ':resize +2<CR>', { desc = 'Increase windows horizontal size' })
vim.keymap.set('n', '<M-h>', ':vertical resize -2<CR>', { desc = 'Reduce windows vertical size' })
vim.keymap.set('n', '<M-l>', ':vertical resize +2<CR>', { desc = 'Increase windows vertical size' })

-- Editing vim.keymap.set('v', '<', '<gv', { desc = 'Reduce indentation' })
vim.keymap.set('v', '>', '>gv', { desc = 'Increase indentation' })
vim.keymap.set('i', '<C-e>', '<C-o>A', { desc = 'Jump to end of line' })
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Format
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format' })

-- move block
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Vertical navigation
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Tree viewer
local nvimTreeFocusOrToggle = function()
  local nvimTree = require("nvim-tree.api")
  local currentBuf = vim.api.nvim_get_current_buf()
  local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
  if currentBufFt == "NvimTree" then
    nvimTree.tree.toggle()
  else
    nvimTree.tree.focus()
  end
end

vim.keymap.set('n', '<C-n>', nvimTreeFocusOrToggle, { desc = 'Toggle tree viewer' })

-- vim: ts=2 sts=2 sw=2 et
