return { -- rooter
  "jedi2610/nvim-rooter.lua",
  config = function()
    require("nvim-rooter").setup({
      rooter_patterns = {
        ".git",
        "Makefile",
        "*.sln",
        ".classpath",
        "build/env.sh",
        "Cargo.toml",
        "init.vim",
        "lazy-lock.json",
      },
    })
  end,
}
