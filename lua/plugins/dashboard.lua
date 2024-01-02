return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
    ....      ..                     s                                       
  +^""888h. ~"888h                  :8                .uef^"                 
 8X.  ?8888X  8888f                .88              :d88E          uL   ..   
'888x  8888X  8888~       .u      :888ooo       .   `888E        .@88b  @88R 
'88888 8888X   "88x:   ud8888.  -*8888888  .udR88N   888E .z8k  '"Y888k/"*P  
 `8888 8888X  X88x.  :888'8888.   8888    <888'888k  888E~?888L    Y888L     
   `*` 8888X '88888X d888 '88%"   8888    9888 'Y"   888E  888E     8888     
  ~`...8888X  "88888 8888.+"      8888    9888       888E  888E     `888N    
   x8888888X.   `%8" 8888L       .8888Lu= 9888       888E  888E  .u./"888&   
  '%"*8888888h.   "  '8888c. .+  ^%888*   ?8888u../  888E  888E d888" Y888*" 
  ~    888888888!`    "88888%      'Y"     "8888P'  m888N= 888> ` "Y   Y"    
       X888^"""         "YP'                 "P'     `Y"   888               
       `88f                                               J88"               
        88                                                @%                 
        ""                                              :"                   
      ]]


    logo = string.rep("\n", 8) .. logo .. "\n\n"
    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
          { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
          { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config", icon = " ", key = "c" },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
