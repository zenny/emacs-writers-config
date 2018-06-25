;; ====== init.el ======
;; Built on ideas from scimax and other places
;; Principle of KISS but leave room for powerful things
;; Matthew Adams
;; 2017-10-28
;; Refactoring 2018-06-24

;; Garbage collection is less frequent
(setq gc-cons-threshold 80000000)

;; Encourage Emacs 25 or above
(when (version< emacs-version "25.0")
  (warn "You probably need at least Emacs 25. You should upgrade. You may need to install leuven-theme manually."))

;; ===== Directory structure =====

;; Directory where emacs config is installed
(defconst emacs-main-dir (file-name-directory (or load-file-name (buffer-file-name))))

(defvar emacs-user-dir (expand-file-name "user" emacs-main-dir)
  "User directory for personal code.")

(setq user-emacs-directory emacs-user-dir)
  
(setq package-user-dir (expand-file-name "elpa" emacs-main-dir))

;; ===== Package control and loading =====

(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/") t)

(add-to-list
 'package-archives
 '("org" . "http://orgmode.org/elpa/") t)

(add-to-list 'load-path emacs-main-dir)

(let ((default-directory emacs-main-dir))
  (shell-command "git submodule update --init"))

(require 'bootstrap)

;; Quelpa for grabbing and building packages from source (Github ...)
(use-package quelpa)
(use-package quelpa-use-package)
(quelpa-use-package-activate-advice)

(setq load-prefer-newer t)

;; ====== Bootstrap 'use-package'

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)
(eval-when-compile
  (require 'use-package))

(setq use-package-verbose t
      use-package-minimum-reported-time 0)

(setq use-package-always-ensure t)

;; ====== Global settings =======

(use-package global-settings
  :ensure nil
  :load-path emacs-main-dir
  :init (require 'global-settings)
  :bind
  ("C-x C-b" . ibuffer))

;; ===== Org-mode settings =====

(use-package org-settings
  :ensure nil
  :load-path emacs-main-dir
  :init (require 'org-settings)
  )

;; ===== Web and blogging settings =====

(use-package web-settings
  :ensure nil
  :load-path emacs-main-dir
  :init
  (require 'web-settings) 
  )

;; ===== End matter =====

(provide 'init)

;;; init.el ends here

