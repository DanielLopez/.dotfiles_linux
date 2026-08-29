-- Autoformat
-- merged from kickstart: stylua for lua, `<leader>ff` to format
return {
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "[F]ormat buffer",
      },
    },
  },
}