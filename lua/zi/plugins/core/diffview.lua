-- resolve the repo's default branch, checked in the current file's repo
local function default_branch()
  local cwd = vim.fn.expand("%:p:h")
  for _, branch in ipairs({ "main", "master" }) do
    local ret = vim.system(
      { "git", "show-ref", "--verify", "--quiet", "refs/heads/" .. branch },
      { cwd = cwd }
    ):wait()
    if ret.code == 0 then
      return branch
    end
  end
  return "main"
end

return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      {
        "<leader>hd",
        function()
          vim.cmd("DiffviewOpen HEAD~1..HEAD -- " .. vim.fn.fnameescape(vim.fn.expand("%:p")))
        end,
        desc = "Diff file: previous commit vs current commit",
      },
      {
        -- uncommitted changes vs HEAD
        "<leader>hD",
        "<Cmd>DiffviewOpen<CR>",
        desc = "Diff: uncommitted changes vs HEAD",
      },
      {
        "<leader>hm",
        function()
          vim.cmd("DiffviewOpen " .. default_branch() .. "..HEAD -- " .. vim.fn.fnameescape(vim.fn.expand("%:p")))
        end,
        desc = "Diff file: main/master vs current commit",
      },
    },
  },
}
