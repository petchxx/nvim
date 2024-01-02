return {
    -- add gruvbox
    { "navarasu/onedark.nvim" },
  
    -- Configure LazyVim to load gruvbox
    {
      "LazyVim/LazyVim",
      config = function()
        vim.g.onedark_config = {
          style = 'deep',
        }
        vim.cmd("colorscheme onedark")
      end,
    },
}