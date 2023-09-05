local commander = require("commander")

commander.add({
  {
    desc = "GHOpenPr",
    cmd = "<Cmd>GHOpenPR<Cr>",
  },
  {
    desc = "Diffview Current Buffer",
    cmd = "<Cmd>DiffviewFileHistory %<Cr>",
  },
  {
    desc = "IconPickerInsert",
    cmd = "<Cmd>IconPickerInsert<Cr>",
  },
  {
    desc = "Luapad (Scratch)",
    cmd = "<Cmd>Luapad<Cr>",
  },
  {
    desc = "Glow Markdown",
    cmd = "<Cmd>lua GlowMarkdown()<Cr>",
  },
  {
    desc = "BufferCloseHidden",
    cmd = "<Cmd>BufferCloseHidden<Cr>",
  },

  -- rust-tools
  {
    desc = "RustSetInlayHints",
    cmd = "<Cmd>RustSetInlayHints<Cr>",
  },
  {
    desc = "RustUnsetInlayHints",
    cmd = "<Cmd>RustUnsetInlayHints<Cr>",
  },
  {
    desc = "RustExpandMacro",
    cmd = "<Cmd>RustExpandMacro<Cr>",
  },
  -- Telescope
  {
    desc = "Telescope jumplist",
    cmd = "<Cmd>Telescope jumplist<Cr>",
  },
  {
    desc = "Telescope spell_suggest",
    cmd = "<Cmd>Telescope spell_suggest<Cr>",
  },
  {
    desc = "Telescope search_history",
    cmd = "<Cmd>Telescope search_history<Cr>",
  },
  {
    desc = "Telescope quickfixhistory",
    cmd = "<Cmd>Telescope quickfixhistory<Cr>",
  },
}, commander.mode.ADD)
