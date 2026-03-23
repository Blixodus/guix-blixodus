(eval-when-compile (require 'use-package))
(setq use-package-always-ensure nil)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

(use-package vertico
  :init (vertico-mode))
(use-package marginalia
  :init (marginalia-mode))
(use-package consult)
(use-package embark)
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package magit)

;; Geiser to work with Scheme implementations in Emacs
(use-package geiser
  :ensure t
  :config
  (setq geiser-default-implementation '(guile)))

(use-package geiser-guile
  :ensure t)

;; Paredit to work with lisp implementations
(use-package paredit
  :hook ((emacs-lisp-mode . paredit-mode)
	 (lisp-mode . paredit-mode)
	 (lisp-interaction-mode . paredit-mode)
	 (scheme-mode . paredit-mode)
	 (clojure-mode . paredit-mode)
	 (cider-repl-mode . paredit-mode)
	 (eval-expression-minibuffer-setup . paredit-mode)
	 (ielm-mode . paredit-mode)
	 (lisp-mode . enable-paredit-mode)
	 (racket-mode . enable-paredit-mode)
	 (racket-repl-mode . enable-paredit-mode)
	 (scheme-mode . enable-paredit-mode)
	 (clojure-mode . enable-paredit-mode)
	 (cider-repl-mode . enable-paredit-mode)
	 (eval-expression-minibuffer-setup . enable-paredit-mode)
	 (ielm-mode . enable-paredit-mode)))

;; Guix package manager utility for Emacs
(use-package guix)

;; Set font last to make sure it stays
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(modus-vivendi))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Term Slab" :foundry "UKWN" :slant normal :weight regular :height 120 :width normal)))))
