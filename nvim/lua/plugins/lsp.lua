return {
  {
   "neovim/nvim-lspconfig",
       opts = {
       inlay_hints = {
         enabled = false,
       },
      diagnostics = {
        globals = {"vim"}
      },
    },
  },
vim.lsp.enable("bashls");
vim.lsp.enable("ansiblels");
vim.lsp.enable("helm_ls");
vim.lsp.enable("lua_ls");
vim.lsp.enable("marksman");
vim.lsp.enable("stylua");
vim.lsp.enable("terraform-ls");
vim.lsp.enable("yamlls");
}
