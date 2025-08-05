if vim.g.loaded_quill then
  return
end

vim.g.loaded_quill = true

vim.g.quill_config = {}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("quill:lspattach", {
    clear = true,
  }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    require("quill.signature").setup(client, ev.buf)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "quill:signature.open",
  callback = function()
    require("quill.signature").auto_signature()
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "quill:signature.close",
  callback = function()
    require("quill.signature").close_signature()
  end,
})
