(define-module (blixodus config home)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services))

(define-public home-config
  (home-environment
   (packages (specifications->packages
              (list "texlive-scheme-full" "imagemagick" "ispell"
		    "python" "python-lsp-server" "python-lsp-black" "python-numpy" "python-scipy" "python-matplotlib" "python-black" "python-black-macchiato"
		    "typst" "tree-sitter-typst" "emacs-typst-ts-mode"
		    "gcc-toolchain" "clang-toolchain" "rust" "rust-analyzer" "python-lsp-server"
		    "git" "gnupg" "openssh"
		    "font-iosevka-term-slab"
		    "wmctrl" "emacs-ewmctrl"
		    "tree-sitter-c" "tree-sitter-cpp" "tree-sitter-python" "tree-sitter-rust" "tree-sitter-latex"
		    "emacs"
		    "emacs-use-package" "emacs-treesit-auto"
		    "emacs-yasnippet" "emacs-yasnippet-snippets" "emacs-doom-snippets"
		    "emacs-vertico" "emacs-marginalia" "emacs-consult" "emacs-embark" "emacs-orderless" "emacs-corfu" "emacs-cape" "emacs-company"
		    "emacs-geiser" "emacs-geiser-guile" "emacs-guix"
		    "emacs-magit"
		    "emacs-paredit"
		    "emacs-org" "emacs-org-roam"
		    "emacs-python-black"
		    "emacs-auctex" "emacs-cdlatex" "emacs-xenops")))
   
   (services (list (service home-files-service-type
			    `((".config/emacs/init.el" ,(local-file "./files/init.el"))))))))

home-config
