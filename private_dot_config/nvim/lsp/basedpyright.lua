return {
  cmd = {'basedpyright-langserver','--stdio'},
  root_markers = {
    'package.py',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
  },
  filetypes = {'python'},
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
}
