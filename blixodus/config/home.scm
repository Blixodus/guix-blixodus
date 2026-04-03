(define-module (blixodus config home)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services))

(define-public home-config
  (home-environment
   (packages (specifications->packages
              (list "texlive-scheme-full" "imagemagick"
		    ;"firefox" "signal-desktop" "steam"
		    "gcc-toolchain" "clang-toolchain"
		    "git"
		    "font-iosevka-term-slab"
		    "wmctrl" "emacs-ewmctrl"
		    "emacs"
		    "emacs-use-package"
		    "emacs-vertico" "emacs-marginalia" "emacs-consult" "emacs-embark" "emacs-orderless" "emacs-corfu"
		    "emacs-geiser" "emacs-geiser-guile" "emacs-guix"
		    "emacs-magit"
		    "emacs-paredit"
		    "emacs-org" "emacs-org-roam"
		    "emacs-eglot")))
   
   (services (list (service home-files-service-type
			    `((".config/emacs/init.el" ,(local-file "./files/init.el"))))))))

home-config
