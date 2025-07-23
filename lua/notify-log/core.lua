local M = {}

-- A private table to hold the configuration once it's set.
-- This is a "local upvalue" that the module's functions can access.
local C = {}

--- Clears the notification log register.
function M.clear()
	if not C.register then
		return
	end -- Guard against being called before setup
	vim.fn.setreg(C.register, "")
	vim.notify(C.clear_message, "info", { title = C.plugin_name })
end

--- Copies the notification log register to the clipboard.
function M.copy()
	if not C.register then
		return
	end -- Guard clause
	local content = vim.fn.getreg(C.register)
	if content and content ~= "" then
		vim.fn.setreg("+", content)
		vim.notify(C.copy_message, "info", { title = C.plugin_name })
	else
		vim.notify(C.empty_message, "warn", { title = C.plugin_name })
	end
end

--- Initializes the core module.
-- Sets up the vim.notify hook and stores the config for other functions.
-- @param config The final, merged configuration table.
function M.setup(config)
	-- Store the passed-in config in our private 'C' table for M.clear and M.copy to use.
	C = config

	-- Set up the notify interception logic
	local original_notify = vim.notify
	vim.notify = function(message, level, opts)
		local msg_text = type(message) == "table" and table.concat(message, "\n") or tostring(message)
		local current_content = vim.fn.getreg(C.register)
		local new_content = (current_content == "" or current_content == nil) and msg_text
			or (current_content .. "\n" .. msg_text)

		vim.fn.setreg(C.register, new_content)

		original_notify(message, level, opts)
	end
end

return M
