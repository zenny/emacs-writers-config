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

;; Startup theme
(load-theme 'doom-peacock t)

;; Set themes index
(setq owl/themes '(doom-peacock doom-nova doom-one-light doom-molokai doom-vibrant doom-one doom-tomorrow-night leuven))
(setq owl/themes-index 0)

;; Function to cycle through themes
(defun owl/cycle-theme ()
  (interactive)
  (setq owl/themes-index (% (1+ owl/themes-index) (length owl/themes)))
  (owl/load-indexed-theme))

(global-set-key (kbd "C-c C-t") 'owl/cycle-theme)

;; Load indexed theme and disable previous theme to prevent overlay
(defun owl/load-indexed-theme ()
  (owl/try-load-theme (nth owl/themes-index owl/themes)))

(defun owl/try-load-theme (theme)
  (if (ignore-errors (load-theme theme :no-confirm))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))

;; Default fonts
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

;; Cursor color
(set-cursor-color "#ffffff")

;; Change cursor shape
(setq-default cursor-type 'box)

;; Show lines and column numbers
(line-number-mode 1)
(column-number-mode 1)

(provide 'global-settings)

;; end of file
