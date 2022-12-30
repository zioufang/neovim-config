vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
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
