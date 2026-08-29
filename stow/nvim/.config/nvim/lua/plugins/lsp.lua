-- LSP servers
-- merged from kickstart: enable gopls and configure lua_ls snippets
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
  },
}