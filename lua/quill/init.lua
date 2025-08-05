local M = {}

---@type quill.config
M.default_config = {
  enable = true,
  window = {
    height = 20,
    width = 64,
  },
}

---@param cfg? quill.config
M.setup = function(cfg)
  cfg = cfg or {}
  vim.g.quill_config = vim.tbl_deep_extend("force", M.default_config, cfg)
end

return M
