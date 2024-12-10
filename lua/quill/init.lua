local M = {}

_G.quill = _G.quill or {
	config = {},
	ns = nil,
}

---@type quill.config
local default_config = {
	enable = true,
	signature = {
		active_parameter_hl = { link = "LspSignatureActiveParameter" },
		window = {
			height = 20,
			width = 64,
		},
	},
}

---@param config? quill.config
M.setup = function(config)
	config = config or {}

	_G.quill.config = vim.tbl_deep_extend("force", default_config, config)

	M.setup_hl()

	local group = {}

	group.lsp = vim.api.nvim_create_augroup("QuillLspAttach", {
		clear = true,
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = group.lsp,
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if not client then
				return
			end

			require("quill.signature").setup(client, ev.buf)
		end,
	})
end

M.setup_hl = function()
	local cfg = _G.quill.config
	quill.ns = quill.ns or vim.api.nvim_create_namespace("quill")
	vim.api.nvim_set_hl(quill.ns, "ActiveParameter", cfg.signature.active_parameter_hl)
end

return M
