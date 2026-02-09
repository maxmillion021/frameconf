return {
  {
   -- "catppuccin/nvim",
    -- name = "catppuccin",
    -- priority = 1000,
    -- "scottmckendry/cyberdream.nvim",
    -- lazy = false,
    -- priority = 1000,
  --   'ribru17/bamboo.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('bamboo').setup {
  --       style = 'vulgaris'
  --     }
  --     require('bamboo').load()
  --   end,
    "rose-pine/neovim",
	  name = "rose-pine",
    priority = 1000,
  },

   {
     "LazyVim/LazyVim",
     opts = {
      colorscheme= "rose-pine-moon",
     },
  },
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[
   █████████             █████               ███   █████         █████████             █████               ███   █████   
  ███░░░░░███           ░░███               ░░░   ░░███         ███░░░░░███           ░░███               ░░░   ░░███    
 ░███    ░███  ████████  ░███████   ██████  ████  ███████      ░███    ░███  ████████  ░███████   ██████  ████  ███████  
 ░███████████ ░░███░░███ ░███░░███ ███░░███░░███ ░░░███░       ░███████████ ░░███░░███ ░███░░███ ███░░███░░███ ░░░███░   
 ░███░░░░░███  ░███ ░░░  ░███ ░███░███████  ░███   ░███        ░███░░░░░███  ░███ ░░░  ░███ ░███░███████  ░███   ░███    
 ░███    ░███  ░███      ░███ ░███░███░░░   ░███   ░███ ███    ░███    ░███  ░███      ░███ ░███░███░░░   ░███   ░███ ███
 █████   █████ █████     ████████ ░░██████  █████  ░░█████     █████   █████ █████     ████████ ░░██████  █████  ░░█████ 
░░░░░   ░░░░░ ░░░░░     ░░░░░░░░   ░░░░░░  ░░░░░    ░░░░░     ░░░░░   ░░░░░ ░░░░░     ░░░░░░░░   ░░░░░░  ░░░░░    ░░░░░  
                                                                                                                         
                                                                                                                         
          ]],
        },
      },
    },
  },
}
