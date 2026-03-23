(define-module (blixodus config home)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services))

(define-public home-config
  (home-environment
   (packages (specifications->packages
              (list "firefox" "signal-desktop" "steam"
		    "gnome-tweaks" "gnome-shell-extension-appindicator"
		    "gcc-toolchain" "clang-toolchain"
		    "git"
		    "font-iosevka-term-slab"
		    "emacs"
		    "emacs-use-package"
		    "emacs-vertico" "emacs-marginalia" "emacs-consult" "emacs-embark" "emacs-orderless"
		    "emacs-geiser" "emacs-geiser-guile" "emacs-guix"
		    "emacs-magit"
		    "emacs-paredit")))
   
   (services (list (service home-files-service-type
			    `((".config/emacs/init.el" ,(local-file "./files/init.el"))))))))

home-config
