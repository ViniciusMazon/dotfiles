local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

nvim_treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  ignore_install = { "" },
  autopairs = {
  enable = true,
  },
  highlight = {
   enable = true,
   disable = { "" },
   additional_vim_regex_highlighting = true,
  },
   context_commentstring = {
   enable = true,
   enable_autocmd = false,
  },
  rainbow = {
   enable = true,
   extended_mode = true,
   max_file_lines = nil, 
  },
}
