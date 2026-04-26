(eval-when-compile (require 'use-package))
(setq use-package-always-ensure nil)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

;(display-battery-mode t)
;(display-time-mode t)

;; Use which-key everywhere
(use-package which-key
  :init (which-key-mode))

;; Org-mode configuration
(use-package org
  :ensure t
  :bind (("C-c o l" . 'org-store-link)
	 ("C-c o a" . 'org-agenda)
	 ("C-c o c" . 'org-capture))
  :config
  (setq org-directory      "~/org"
	org-agenda-files   (list "~/org/" "~/org/dailies/")
	org-log-done 'time)
  (setq org-todo-keywords
	'((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)")
	  (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	  (sequence "WAITING(w)" "|" "POSTPONE" "CANCELED(c)")))
  (setq org-todo-keyword-faces
	'(("STARTED" . "orange")
	  ("WAITING" . "magenta")
	  ("POSTPONE" . "blue"))))

(use-package org-roam
  :ensure t
  :bind (("C-c o r f" . 'org-roam-node-find)
	 ("C-c o r l" . 'org-roam-node-insert)
	 ("C-c o r c" . 'org-roam-capture)
	 ("C-c o d t" . 'org-roam-dailies-capture-today)
	 ("C-c o d g" . 'org-roam-dailies-goto-today)
	 ("C-c o d r" . 'org-roam-dailies-capture-tomorrow)
	 ("C-c o d f" . 'org-roam-dailies-goto-tomorrow)
	 ("C-c o d y" . 'org-roam-dailies-capture-yesterday)
	 ("C-c o d h" . 'org-roam-dailies-goto-yesterday)
	 ("C-c o d e" . 'org-roam-dailies-capture-date)
	 ("C-c o d d" . 'org-roam-dailies-goto-date)
	 ("C-c o d n" . 'org-roam-dailies-goto-next-note)
	 ("C-c o d p" . 'org-roam-dailies-goto-previous-note))
  :config
  (setq org-roam-directory (file-truename "~/org"))
  (setq org-roam-dailies-directory "dailies")
  (setq org-roam-dailies-capture-templates
	'(("d" "default" entry
	   "* %?"
	   :target (file+head "%<%Y-%m-%d>.org"
			      "#+title: %<%Y-%m-%d>\n"))))
  (org-roam-db-autosync-mode))


;; Set regex mode for re-builder to string
(use-package re-builder
  :config (setq reb-re-syntax 'string))

;; Tree-sitter configuration automatically
(use-package treesit-auto
  :config (global-treesit-auto-mode))

(use-package yasnippet
  :init (yas-global-mode))

;; Vertico configuration
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

;; Completion through company which provides an interface for
;; completions (eventually corfu some day)
(use-package company
  :init (global-company-mode))

(use-package magit)

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

;; Geiser to work with Scheme implementations in Emacs
(use-package geiser
  :config
  (setq geiser-default-implementation '(guile)))

(use-package geiser-guile)

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
