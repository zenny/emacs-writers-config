;;; ====== Install and configure various emacs packages =====

(setq use-package-always-ensure t)

;; ====== General settings =======

(use-package global-settings
  :ensure nil
  :load-path emacs-main-dir
  :init (require 'global-settings)
  :bind
  ("C-x C-b" . ibuffer))

;; ===== Pdf-tools =====

;; Thing is a toad to install
;; https://github.com/politza/pdf-tools
;; ~/builds/pdf-tools contains some necessary files

(use-package let-alist
  :ensure t)

(use-package tablist
  :ensure t)

;; Comment out this line if Emacs daemon won't start
;(pdf-tools-install)

;; Interleave
(use-package interleave
  :ensure t)

;; ===== Org mode =====

(use-package org-settings
  :ensure nil
  :load-path emacs-main-dir
  :init (require 'org-settings)
  )

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
  (setq easy-hugo-basedir "~/public_workspace")
  (setq easy-hugo-postdir "content/posts")
  (setq easy-hugo-url "http://www.matthew-edward-adams.org")
  (setq easy-hugo-sshdomain "~/.ssh/config")
  (setq easy-hugo-root "~/public_workspace")
  (setq easy-hugo-previewtime "300")
  (setq easy-hugo-default-ext ".org")
  :bind ( "C-c C-n p" . easy-hugo)
  )

;; ===== Elfeed for RSS feeds =====

(use-package elfeed
  :ensure t
  :bind ("C-x w" . elfeed)
  :init
  (setq elfeed-use-curl t)
  (use-package elfeed-org
    :ensure t
    :init 
    (setq rmh-elfeed-org-files (list "~/org/elfeed.org"))
    )
  :config
  (define-key elfeed-show-mode-map (kbd "j") 'next-line)
  (define-key elfeed-show-mode-map (kbd "k") 'previous-line)
  (use-package elfeed-web
    :ensure t
    ))

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
