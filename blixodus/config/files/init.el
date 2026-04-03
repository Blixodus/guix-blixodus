(eval-when-compile (require 'use-package))
(setq use-package-always-ensure nil)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

;(display-battery-mode t)
;(display-time-mode t)

;; EXWM configuration
;; (when (get-buffer "*window-manager*")
;;   (kill-buffer "*window-manager*"))
;; (when (get-buffer "*window-manager-error*")
;;   (kill-buffer "*window-manager-error*"))
;; (when (executable-find "wmctrl")
;;   (shell-command "wmctrl -m ; echo $?" "*window-manager*" "*window-manager-error*"))

;;   ;; if there was an error detecting the window manager, initialize EXWM
;;   (when (and (get-buffer "*window-manager-error*")
;;              (eq window-system 'x))
;;     ;; exwm startup goes here
;;     (use-package exwm
;;       :ensure t
;;       :config
;;       ;; necessary to configure exwm manually
;;       ;(require 'exwm-config)
;;       ;; fringe size, most people prefer 1 
;;       ;(fringe-mode 3)
;;       ;; emacs as a daemon, use "emacsclient <filename>" to seamlessly edit files from the terminal directly in the exwm instance
;;       ;(server-start)
;;       ;; this fixes issues with ido mode, if you use helm, get rid of it
;;       ;(exwm-config-ido)
;;       ;; a number between 1 and 9, exwm creates workspaces dynamically so I like starting out with 1
;;       (setq exwm-workspace-number 1)
;;       ;; this is a way to declare truly global/always working keybindings
;;       ;; this is a nifty way to go back from char mode to line mode without using the mouse
;;       (exwm-input-set-key (kbd "s-r") #'exwm-reset)
;;       (exwm-input-set-key (kbd "s-k") #'exwm-workspace-delete)
;;       (exwm-input-set-key (kbd "s-w") #'exwm-workspace-swap)
;;       ;; (exwm-input-set-key (kbd "s-f2") #'(lambda ()
;;       ;; 					   (interactive)
;;       ;; 					   (start-process "" nil "/usr/bin/slock")))
;;       ;; the next loop will bind s-<number> to switch to the corresponding workspace
;;       (dotimes (i 10)
;;         (exwm-input-set-key (kbd (format "s-%d" i))
;;                             `(lambda ()
;;                                (interactive)
;;                                (exwm-workspace-switch-create ,i))))
;;       ;; the simplest launcher, I keep it in only if dmenu eventually stopped working or something
;;       (exwm-input-set-key (kbd "s-&")
;;                           (lambda (command)
;;                             (interactive (list (read-shell-command "$ ")))
;;                             (start-process-shell-command command nil command)))
;;       ;; an easy way to make keybindings work *only* in line mode
;;       (push ?\C-q exwm-input-prefix-keys)
;;       (define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
;;       ;; simulation keys are keys that exwm will send to the exwm buffer upon inputting a key combination
;;       (exwm-input-set-simulation-keys
;;        '(
;;          ;; movement
;;          ([?\C-b] . left)
;;          ([?\M-b] . C-left)
;;          ([?\C-f] . right)
;;          ([?\M-f] . C-right)
;;          ([?\C-p] . up)
;;          ([?\C-n] . down)
;;          ([?\C-a] . home)
;;          ([?\C-e] . end)
;;          ([?\M-v] . prior)
;;          ([?\C-v] . next)
;;          ([?\C-d] . delete)
;;          ([?\C-k] . (S-end delete))
;;          ;; cut/paste
;;          ([?\C-w] . ?\C-x)
;;          ([?\M-w] . ?\C-c)
;;          ([?\C-y] . ?\C-v)
;;          ;; search
;;          ([?\C-s] . ?\C-f)))
;;       ;; this little bit will make sure that XF86 keys work in exwm buffers as well
;;       (dolist (k '(XF86AudioLowerVolume
;;                    XF86AudioRaiseVolume
;;                    XF86PowerOff
;;                    XF86AudioMute
;;                    XF86AudioPlay
;;                    XF86AudioStop
;;                    XF86AudioPrev
;;                    XF86AudioNext
;;                    XF86ScreenSaver
;;                    XF68Back
;;                    XF86Forward
;;                    Scroll_Lock
;;                    print))
;; 	(cl-pushnew k exwm-input-prefix-keys))
;;       ;; this just enables exwm, it started automatically once everything is ready
;;       (exwm-enable)))
;; (when (get-buffer "*window-manager*")
;;   (kill-buffer "*window-manager*"))
;; (when (get-buffer "*window-manager-error*")
;;   (kill-buffer "*window-manager-error*"))

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
