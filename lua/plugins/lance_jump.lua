local M = {}

-- -- Function to open jump list and prompt for a jump index
-- function M.jump_to_index()
--   vim.cmd("jumps")
--   local index = vim.fn.input("Enter jump index: ")
--   if tonumber(index) then
--     local jump_index = tonumber(index) - 1
--     if jump_index >= 0 then
--       vim.cmd("normal! " .. jump_index .. "<C-o>")
--     else
--       print("Invalid index")
--     end
--   else
--     print("Invalid input")
--   end
-- end

return M
