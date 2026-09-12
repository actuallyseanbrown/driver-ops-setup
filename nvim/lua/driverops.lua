-- Sean driver-ops helpers for kickstart.nvim
-- require('driverops') from init.lua

local M = {}

local function client_root()
  return vim.env.DRIVER_OPS_CLIENT
    or (vim.env.HOME .. '/driver-ops/clients/demo')
end

function M.open_catalog()
  vim.cmd('edit ' .. client_root() .. '/catalog/drivers.csv')
end

function M.open_notes()
  local shape = vim.fn.input('source shape name: ')
  if shape == nil or shape == '' then return end
  local dir = client_root() .. '/recipes/' .. shape
  vim.fn.mkdir(dir, 'p')
  local path = dir .. '/NOTES.md'
  if vim.fn.filereadable(path) == 0 then
    if vim.fn.filereadable(vim.env.HOME .. '/driver-ops/NOTES_TEMPLATE.md') == 1 then
      vim.fn.writefile(vim.fn.readfile(vim.env.HOME .. '/driver-ops/NOTES_TEMPLATE.md'), path)
    else
      vim.fn.writefile({
        '# Recipe notes — ' .. shape, '',
        '**Raw file(s):** `raw/`', '**Ingested:** ', '',
        '## What I did', '- ', '',
        '## Drivers this feeds', '- ', '',
        '## Crunch ship?',
        '- [ ] Exported to staging/',
        '- [ ] Promote to recipe within 24h',
      }, path)
    end
  end
  vim.cmd('edit ' .. path)
end

function M.open_root()
  vim.cmd('edit ' .. (vim.env.HOME .. '/driver-ops'))
end

vim.api.nvim_create_user_command('Catalog', M.open_catalog, {})
vim.api.nvim_create_user_command('Notes', M.open_notes, {})
vim.api.nvim_create_user_command('DriverOps', M.open_root, {})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.csv',
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.list = true
  end,
})

return M
