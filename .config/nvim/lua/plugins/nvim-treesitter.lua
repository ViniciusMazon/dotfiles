local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

nvim_treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'css', 'html', 'javascript', 'json', 'lua', 
    'typescript', 'vim', 'yaml', 'tsx', 'sql', 'dockerfile', 'dot', 'markdown', 'php', 'regex', 'vue'
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}
