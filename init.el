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
  (warn "Dude, Emacs 25 or above, please."))

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

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

(add-to-list 'load-path emacs-main-dir)

(let ((default-directory emacs-main-dir))
  (shell-command "git submodule update --init"))

;;(require 'bootstrap)

;; Quelpa for grabbing and building packages from source (Github ...)

;; Bootstrap quelpa
;; (if (require 'quelpa nil t)
;;     (quelpa-self-upgrade)
;;   (with-temp-buffer
;;     (url-insert-file-contents
;;      "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
;;     (eval-buffer)))

;; Make Quelpa prefer MELPA-stable over melpa. This is optional but
;; highly recommended.
;;
;; (setq quelpa-stable-p t)

;; Install quelpa-use-package, which will install use-package as well
;;(quelpa
;; '(quelpa-use-package
;;   :fetcher github
;;   :repo "quelpa/quelpa-use-package"
;;   :stable nil))
;;(require 'quelpa-use-package)

;;(quelpa-use-package-activate-advice)

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

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-interval 4)
  (auto-package-update-maybe))

;; ====== Global settings =======

(use-package global-settings
  :ensure nil
  :load-path emacs-main-dir
  :init (require 'global-settings)
  )

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

