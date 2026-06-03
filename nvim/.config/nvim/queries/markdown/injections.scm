; Override nvim-treesitter's archived (master-branch) markdown injections.
; Its `#set-lang-from-info-string!` directive breaks on Neovim 0.11+ because
; directive matches are now node lists, not single nodes. This native query
; (from $VIMRUNTIME) uses an @injection.language capture instead. No `; extends`
; modeline so it becomes the base query and shadows the broken one.

(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
