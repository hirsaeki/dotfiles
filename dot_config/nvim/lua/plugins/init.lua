-- nvim/lua/plugins/init.lua
local utils = require('libraries._set_config')
local conf = utils.conf

vim.cmd('packadd vim-jetpack')
require('jetpack').startup(function(use)
  use ''
  use {
    'itchyny/lightline.vim'
    config = conf 'lightline'
  }

  use 'altercation/vim-colors-solarized'

end)
