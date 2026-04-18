-- bootstrap lazy.nvim
require("config.lazy")

-- lemonade clipboard
vim.g.clipboard = {
  name = 'lemonade',
  copy = {
    ['+'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' copy',
    ['*'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' copy',
  },
  paste = {
    ['+'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' paste',
    ['*'] = 'lemonade --host ' .. vim.env.LEMONADE_HOST .. ' paste',
  },
  cache_enabled = false,
}
