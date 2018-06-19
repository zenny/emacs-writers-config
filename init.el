;; ====== init.el ======
;; Built on ideas from scimax and other places
;; Principle of KISS but leave room for powerful things
;; Matthew Adams
;; 2017-10-28

;; Must come before configurations of installed packages
(package-initialize nil)

;; Garbage collection is less frequent
(setq gc-cons-threshold 80000000)

;; Encourage Emacs 25 or above
(when (version< emacs-version "25.0")
  (warn "You probably need at least Emacs 25. You should upgrade. You may need to install leuven-theme manually."))

;; UTF-8
(set-language-environment "UTF-8")

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

;; ====== Bootstrap 'use-package'

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)
(eval-when-compile
  (require 'use-package))

;; it appears this help library is not loaded fully in the emacs-win
;; directory. See issue #119. This appears to fix that.
(when (file-directory-p (expand-file-name "emacs-win" emacs-main-dir))
  (load-library "help"))

(require 'packages)

(provide 'init)

;;; init.el ends here
