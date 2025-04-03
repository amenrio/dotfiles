return {
  cmd = { 'sith-lsp' },
  root_markers = {
    'package.py',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
  },
  filetypes = { 'python' },
  init_options = {
    settings = {
      ruff = {
        lint = {
          enable = true
        },
      },
    },
  },
}
