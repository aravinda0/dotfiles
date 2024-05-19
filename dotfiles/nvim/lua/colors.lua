-- --------------------------------------------------------------------------------
-- Highlight customization
-- --------------------------------------------------------------------------------
vim.cmd([[
  highlight DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold
]])


-- Keep sign column hidden - just underline issues.
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticLineNrError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticLineNrWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticLineNrInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticLineNrHint',
    }
  }
})
