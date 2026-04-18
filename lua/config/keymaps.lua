local map = vim.keymap.set

-- General
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit All" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "No Highlight" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete Other Buffers" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Quickfix
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous Quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })

-- C/C++ specific
map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Header/Source" })
map("n", "<leader>cs", "<cmd>!ctags -R .<cr>", { desc = "Generate ctags" })

-- Theme switching
local themes = { "tokyonight", "catppuccin", "gruvbox", "kanagawa", "onedark", "everforest" }
local theme_file = vim.fn.stdpath("config") .. "/.theme"

local function save_theme(theme)
  local f = io.open(theme_file, "w")
  if f then
    f:write(theme)
    f:close()
  end
end

local function load_theme()
  local f = io.open(theme_file, "r")
  if f then
    local theme = f:read("*all")
    f:close()
    vim.cmd.colorscheme(theme)
    return theme
  end
  return nil
end

local function get_theme_index(theme)
  for i, t in ipairs(themes) do
    if t == theme then
      return i
    end
  end
  return 1
end

local current_theme_index = 1

map("n", "<leader>ut", function()
  vim.ui.input({
    prompt = "Enter colorscheme: ",
    default = "tokyonight",
    completion = "colorscheme",
  }, function(input)
    if input then
      vim.cmd.colorscheme(input)
      save_theme(input)
    end
  end)
end, { desc = "Select Colorscheme" })

map("n", "<leader>tn", function()
  current_theme_index = (current_theme_index % #themes) + 1
  local theme = themes[current_theme_index]
  vim.cmd.colorscheme(theme)
  save_theme(theme)
end, { desc = "Next Colorscheme" })

map("n", "<leader>tp", function()
  current_theme_index = ((current_theme_index - 2 + #themes) % #themes) + 1
  local theme = themes[current_theme_index]
  vim.cmd.colorscheme(theme)
  save_theme(theme)
end, { desc = "Previous Colorscheme" })
