vim.cmd([[
command! -nargs=* BufferCloseHidden call BufferCloseHidden()
function! BufferCloseHidden()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bdelete! ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun
]])

function _G.ReloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match("^zi") then -- deletiong `zi` namespace only
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end
