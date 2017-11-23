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

;; ===== Web browsers, EWW, and Firefox =====

(use-package web-settings
  :ensure nil
  :load-path emacs-main-dir
  :init
  (require 'web-settings)
  )

;; ===== Easy Hugo ======

(use-package easy-hugo
  :ensure t
  :init
  (setq easy-hugo-basedir "~/workspace/")
  (setq easy-hugo-url "http://www.matthew-edward-adams.org")
  (setq easy-hugo-sshdomain "~/.ssh/config")
  (setq easy-hugo-root "~/linguistgate.github.io/")
  (setq easy-hugo-previewtime "300")
  (setq easy-hugo-default-ext ".org")
  :bind ( "C-c C-w" . easy-hugo) 
  )

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

;; ===== Elfeed for RSS feeds =====

(use-package elfeed
  :ensure t
  :bind ("C-x w" . elfeed)
  :init
  ;; URLs in no particular order
  (setq elfeed-use-curl t)
  (setq elfeed-feeds
        '(;; Blogs
          ("http://blag.xkcd.com/feed/" blog)
          ("http://newartisans.com/rss.xml" blog emacs)
          ("http://blog.nullspace.io/feed.xml" blog)
          ("https://codewords.recurse.com/feed.xml" blog)
          ("http://neverworkintheory.org/feed.xml" blog)
          ("http://maryrosecook.com/blog/feed" blog)

	  ;; German language
	  ("http://rss.dw.com/atom/rss-de-news" german news)
	  
	  ;; Theology

	  ;; Github feeds

	  ;; Linux
	  ("http://www.phoronix.com/rss.php" linux news)
	  ("http://fedoramagazine.org/feed/" linux)
	  ("http://feeds.feedburner.com/mylinuxrig" linux)

	  ;; Emacs
	  ("http://oremacs.com/atom.xml" emacs)
	  ("http://www.lunaryorn.com/feed.atom" emacs)
	  ("http://emacsnyc.org/atom.xml" emacs)
	  ("http://emacsredux.com/atom.xml" emacs)
	  ("http://www.masteringemacs.org/feed/" emacs)
	  ("http://planet.emacsen.org/atom.xml" emacs)
	  ("http://endlessparentheses.com/atom.xml" emacs)

	  ;; News
	  ("http://feeds.arstechnica.com/arstechnica/index/" news)
	  ("http://www.osnews.com/files/recent.xml" news)
	  ("http://acculturated.com/feed/" news)
	  ("https://opensource.com/feed" news)

	  ;; Flickr

	  ;; Reddit
	  ("https://www.reddit.com/r/emacs/.rss" emacs reddit)
	  ("https://www.reddit.com/r/orgmode/.rss" emacs reddit)
	  ("https://www.reddit.com/r/elasticsearch/.rss" elasticsearch reddit)
	  ("https://www.reddit.com/r/elastic/.rss" elasticsearch reddit)

	  ;; Other

	  
	  ))
  :config
  (define-key elfeed-show-mode-map (kbd "j") 'next-line)
  (define-key elfeed-show-mode-map (kbd "k") 'previous-line))

;; ==== Visual undo =====

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode t)
  :defer t
  :diminish ""
  :config
  (progn
    (define-key undo-tree-map (kbd "C-x u") 'undo-tree-visualize)
    (define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)))

;; ===== The weather =====
(use-package wttrin
  :ensure t
  :init
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
  (setq wttrin-default-cities '("San Diego" "Aix-en-Provence" "Olympia"
				"Seoul")))

;; ===== Other packages ======

(use-package aggressive-indent
  :config (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

;; Stack Exchange client
(use-package sx
  :ensure t)

;; Rainbow mode
;; When activated, all strings representing colors will
;; be highlighted with the color they represent.
(use-package rainbow-mode
  :ensure t)

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
