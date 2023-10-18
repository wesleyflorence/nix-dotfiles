return { "goerz/jupytext.vim",  -- edit jupyter notebooks
  dependencies = {
    'kana/vim-textobj-user',
    'kana/vim-textobj-line',
    'GCBallesteros/vim-textobj-hydrogen' -- highlight cells
  },
  config =  function ()
    vim.g.jupytext_fmt = 'py:percent'
  end
}
