local packer_install_path =
  vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'


local ensure_packer = function()
  local fn = vim.fn
  if fn.empty(fn.glob(packer_install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', packer_install_path
    })
    vim.cmd("packadd packer.nvim")
    return true
  end

  return false
end


local packer_bootstrap = ensure_packer()


require("packer").startup({
  function(use)
    -- `packer` can manage itself
    use {"wbthomason/packer.nvim"}

    -- `treesitter` and related extensions
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function() require("plugins.nvim_treesitter_config").setup() end,
    }
    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      requires = "nvim-treesitter/nvim-treesitter",
    }

    -- The configurator here invokes `require("plugins.lang").setup() which configures
    -- `lspconfig`, `nvim-cmp` and `luasnip`.
    -- There is a bit of interdependency where they are all configured together.
    use {
      "neovim/nvim-lspconfig",
      config = function() require("plugins.lang").setup() end,
    }

    -- Completion
    use {"hrsh7th/nvim-cmp"}
    use {
      "hrsh7th/cmp-nvim-lsp",
      requires = "hrsh7th/nvim-cmp",
    }
    use {
      "hrsh7th/cmp-buffer",
      requires = "hrsh7th/nvim-cmp",
    }
    use {
      "hrsh7th/cmp-path",
      requires = "hrsh7th/nvim-cmp",
    }
    use {
      "hrsh7th/cmp-cmdline",
      requires = "hrsh7th/nvim-cmp",
    }

    -- nvim-cmp says signature hints support is out-of-scope, since it's not part of the
    -- LSP spec. This plugin is recommended.
    use {
      "ray-x/lsp_signature.nvim",
      config = function() require("plugins.lsp_signature_config").setup() end,
    }

    -- Snippets
    use {"L3MON4D3/LuaSnip"}
    use {"rafamadriz/friendly-snippets"}
    use {
      "saadparwaiz1/cmp_luasnip",
      requires = {"hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip"},
    }

    -- Telescope
    use {"nvim-lua/plenary.nvim"}
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    }
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
      },
      config = function() require("plugins.telescope_config").setup() end,
    }

    -- Indentation
    use {"lukas-reineke/indent-blankline.nvim"}
    use {
      "Vimjas/vim-python-pep8-indent",
      ft = {"python"},
      config = function() require("plugins.indent_blankline_config").setup() end,
    }

    -- Formatters
    use {
      "psf/black",
      branch = "main",
      ft = {"python"},
    }

    use {
      "windwp/nvim-autopairs",
      config = function() require("plugins.nvim_autopairs_config").setup() end,
    }

    use {
      "phaazon/hop.nvim",
      config = function() require("hop").setup() end
    }

    use {"tpope/vim-surround"}

    use {
      "nvim-lualine/lualine.nvim",
      config = function() require("plugins.lualine_config").setup() end,
    }

    use {
      "numToStr/Comment.nvim",
      config = function() require("Comment").setup() end,
    }

    use {
      "vimwiki/vimwiki",
      branch = "dev",
      ft = {"markdown", "vimwiki"},
      config = function() require("plugins.vimwiki_config").setup() end,
    }

    use {"sainnhe/gruvbox-material"}

    -- Install all plugins when first bootstrapped
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    compile_path = packer_install_path .. "/plugin/packer_compiled.lua",
  },
})
