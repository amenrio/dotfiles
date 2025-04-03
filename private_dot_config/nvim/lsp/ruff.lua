return {
  cmd = {'ruff', 'server'},
  root_markers = {
    'package.py',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
  },
  filetypes = {'python'},
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
