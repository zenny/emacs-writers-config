;;; ====== Global settings =====

;; ===== Personal information ======

(setq user-full-name "Matthew E. Adams"
      user-mail-address "m2eadams@gmail.com")

;; ===== Unicode ======

(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; ===== Theme and font ======

;;(load-theme 'leuven t)
;;(load-theme 'eziam-dark t)
;;(load-theme 'eziam-light t)
(load-theme 'doom-peacock t)

(add-to-list 'default-frame-alist '(font . "Input Mono 10" ))
(set-face-attribute 'default t :font "Input Mono 10" )

;; Use variable width font faces in current buffer
(defun my-buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "GentiumPlus" :height 100))
  (buffer-face-mode))

;; Use monospaced font faces in current buffer
(defun my-buffer-face-mode-fixed ()
  "Sets a fixed width (monospace) font in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "Input Mono" :height 100))
  (buffer-face-mode))

;; Set default font faces for Info and ERC modes
(add-hook 'erc-mode-hook 'my-buffer-face-mode-variable)
(add-hook 'Info-mode-hook 'my-buffer-face-mode-variable)

;; Control-c + Control-f/v to change font type
(global-set-key (kbd "C-c C-f") 'my-buffer-face-mode-fixed)
(global-set-key (kbd "C-c C-v") 'my-buffer-face-mode-variable)

;; Control-c + Control+Arrows to change font size
(global-set-key (kbd "C-c C-<up>") 'text-scale-increase)
(global-set-key (kbd "C-c C-<down>") 'text-scale-decrease)

;; ===== Startup behavior =====

(setq inhibit-startup-screen t) ;; stop showing startup screen
(tool-bar-mode 0)               ;; remove the icons
(menu-bar-mode 0)               ;; toggle the menu bar

(setq custom-file (expand-file-name "user/custom.el" emacs-main-dir))
      
;; ====== Backup ======

(setq backup-inhibited t)       ;; Disable backup creation

(setq auto-save-list-file-prefix (expand-file-name "auto-save-list/saves-" emacs-main-dir))

(require 'savehist)
(setq savehist-file (concat user-emacs-directory "savehist"))
(savehist-mode 1)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
(setq-default save-place t)

;; ====== Visual appearance and behaviors ======

;; Answer with y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Handle long lines by visual wrapping but no line-returns
(global-visual-line-mode 1)

;; Turn on font-lock everywhere
(global-font-lock-mode t)

(auto-fill-mode -1)             ;; Disprefer auto-fill-mode
(show-paren-mode 1)             ;; Highlight parentheses
(setq show-paren-style 'mixed)  ;; Alternatives: 'expression, 'parenthesis

;; Change cursor shape
(setq-default cursor-type 'box)

;; Show lines and column numbers
(line-number-mode 1)
(column-number-mode 1)

(provide 'global-settings)

;; end of file
