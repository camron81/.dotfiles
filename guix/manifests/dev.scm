(use-modules (gnu packages))

(specifications->manifest
    '(; Bash
      "node" ; bash-language-server only
      "shfmt"
      "shellcheck"
      ; C
      "clang-toolchain"
      "man-pages"
      "man-pages-posix"
      ; Fennel
      "fennel"))
