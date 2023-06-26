(use-modules (gnu packages)
             (packages shfmt))

(concatenate-manifests
  (list
    (specifications->manifest
      '(; Bash
        "node" ; bash-language-server only
        "shellcheck"
        ; C
        "gcc-toolchain"
        "clang-toolchain"
        "man-pages"
        "man-pages-posix"
        ; Fennel
        "fennel"))
    (packages->manifest
      (list shfmt))))
