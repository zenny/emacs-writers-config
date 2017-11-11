;;; ====== Install and configure various emacs packages =====

(setq use-package-always-ensure t)

;; ====== General settings =======

(use-package global-settings
  :ensure nil
  :load-path emacs-main-dir
  :init (require 'global-settings)
  :bind
  ("C-x C-b" . ibuffer))

;; ===== Org mode =====

(use-package org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  :init
  ;; Use the current window for C-c ' source editing
  (setq org-src-window-setup 'current-window
	org-support-shift-select t)
  
  (setq org-return-follows-link t)
  :bind
  (("C-c l" . org-store-link)
   ("C-c L" . org-insert-link-global)
   ("C-c o" . org-open-at-point-global)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("s-<SPC>" . org-mark-ring-goto)
   ("H-." . org-time-stamp-inactive)))

(use-package org-settings
  :ensure nil
  :load-path emacs-main-dir
  :bind
  ("s--" . org-subscript-region-or-point)
  ("s-=" . org-superscript-region-or-point)
  ("s-i" . org-italics-region-or-point)
  ("s-b" . org-bold-region-or-point)
  ("s-v" . org-verbatim-region-or-point)
  ("s-c" . org-code-region-or-point)
  ("s-u" . org-underline-region-or-point)
  ("s-+" . org-strikethrough-region-or-point)
  ("s-4" . org-latex-math-region-or-point)
  ("s-e" . ivy-insert-org-entity)
  :init
  (require 'org-settings))

;; ===== Ivy ======

;; (use-package swiper
;;   :bind
;;   ("C-s" . counsel-grep-or-swiper)
;;   :diminish ivy-mode
;;   :config
;;   (ivy-mode))

;; (use-package counsel
;;   :init
;;   (require 'ivy)
;;   (setq projectile-completion-system 'ivy)
;;   (setq ivy-use-virtual-buffers t)
;;   (define-prefix-command 'counsel-prefix-map)
;;   (global-set-key (kbd "H-c") 'counsel-prefix-map)

;;   ;; default pattern ignores order.
;;   (setf (cdr (assoc t ivy-re-builders-alist))
;; 	'ivy--regex-ignore-order)
;;   :bind
;;   (("M-x" . counsel-M-x)
;;    ("C-x b" . ivy-switch-buffer)
;;    ("C-x C-f" . counsel-find-file)
;;    ("C-h f" . counsel-describe-function)
;;    ("C-h v" . counsel-describe-variable)
;;    ("C-h i" . counsel-info-lookup-symbol)
;;    ("H-c r" . ivy-resume)
;;    ("H-c l" . counsel-load-library)
;;    ("H-c g" . counsel-git-grep)
;;    ("H-c a" . counsel-ag)
;;    ("H-c p" . counsel-pt))
;;   :diminish ""
;;   :config
;;   (progn
;;     (counsel-mode)

;;     (define-key ivy-minibuffer-map (kbd "M-<SPC>") 'ivy-dispatching-done)

;;     ;; C-RET call and go to next
;;     (define-key ivy-minibuffer-map (kbd "C-<return>")
;;       (lambda ()
;; 	"Apply action and move to next/previous candidate."
;; 	(interactive)
;; 	(ivy-call)
;; 	(ivy-next-line)))

;;     ;; M-RET calls action on all candidates to end.
;;     (define-key ivy-minibuffer-map (kbd "M-<return>")
;;       (lambda ()
;; 	"Apply default action to all candidates."
;; 	(interactive)
;; 	(ivy-beginning-of-buffer)
;; 	(loop for i from 0 to (- ivy--length 1)
;; 	      do
;; 	      (ivy-call)
;; 	      (ivy-next-line)
;; 	      (ivy--exhibit))
;; 	(exit-minibuffer)))

;;     ;; s-RET to quit
;;     (define-key ivy-minibuffer-map (kbd "s-<return>")
;;       (lambda ()
;; 	"Exit with no action."
;; 	(interactive)
;; 	(ivy-exit-with-action
;; 	 (lambda (x) nil))))

;;     (define-key ivy-minibuffer-map (kbd "?")
;;       (lambda ()
;; 	(interactive)
;; 	(describe-keymap ivy-minibuffer-map)))

;;     (define-key ivy-minibuffer-map (kbd "<left>") 'ivy-backward-delete-char)
;;     (define-key ivy-minibuffer-map (kbd "<right>") 'ivy-alt-done)
;;     (define-key ivy-minibuffer-map (kbd "C-d") 'ivy-backward-delete-char)))

;; ===== Other packages ======

(use-package aggressive-indent
  :config (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(use-package auto-complete
  :diminish auto-complete-mode
  :config (ac-config-default))

;; Make cursor more invisible when moving over long distance
(use-package beacon
  :config
  (beacon-mode 1))

;; Provide functions for working on lists
(use-package dash)
(use-package dash-functional)

;; Python editing mode
(use-package elpy
  :config
  (elpy-enable))

(provide 'packages)

;; packages.el ends here
