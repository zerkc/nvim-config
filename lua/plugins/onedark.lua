-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return {

  { "navarasu/onedark.nvim", opts = {
    style = "darker"
  } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
