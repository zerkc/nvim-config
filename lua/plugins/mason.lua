-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "typescript-language-server",
        "vue-language-server",
        "tailwindcss-language-server",
        "python-lsp-server",
        "phpcs",
        "json-lsp",
        "eslint-lsp",
        "css-lsp",
      },
    },
  },
}
