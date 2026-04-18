-- bootstrap lazy.nvim
require("config.lazy")

-- lemonade clipboard
vim.g.clipboard = {
  name = 'lemonade',
  copy = {
    ['+'] = 'lemonade copy',
    ['*'] = 'lemonade copy',
  },
  paste = {
    ['+'] = 'lemonade paste',
    ['*'] = 'lemonade paste',
  },
  cache_enabled = false,
}
