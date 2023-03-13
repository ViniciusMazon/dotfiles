-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------
local status_ok, color_scheme = pcall(require, 'monokai')
if not status_ok then
  return
end

require('monokai').setup {
  palette = require('monokai').pro
}

--vim.o.background = "dark" -- or "light" for light mode
--vim.cmd([[colorscheme gruvbox]])
