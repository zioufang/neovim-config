vim.cmd([[
let blacklist = ['fish', 'sql']

augroup fmt
  autocmd!
  autocmd BufWritePre * if index(blacklist, &ft) < 0 | Neoformat | endif
augroup END
]])

-- rustfmt uses 2015 edition by default
-- specify 2018 to format newer syntax like `async fn`
vim.cmd([[
let g:neoformat_rust_rustfmt = {
        \ 'exe': 'rustfmt',
        \ 'args': ['--edition', '2018'],
        \ 'stdin': 1,
    \}
]])
