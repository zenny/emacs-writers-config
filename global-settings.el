;;;  ====== Global settings =====

;; ======  Personal information ======

(setq user-full-name "Matthew E. Adams"
      user-mail-address "m2eadams@gmail.com")

;; ===== Startup behavior =====

(setq inhibit-startup-screen t) ;; stop showing startup screen
(tool-bar-mode 0)               ;; remove the icons
(menu-bar-mode 0)               ;; toggle the menu bar

(setq custom-file (expand-file-name "user/custom.el" emacs-main-dir))

;; ===== Accessibility =====

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode)
  (which-key-setup-side-window-right-bottom)
  (setq which-key-max-description-length 60))

;; Answer with y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(use-package auto-complete
  :diminish auto-complete-mode
  :config (ac-config-default))

;; ====== Emacs string manipulation library ======

(use-package s)

;; ===== Backups ======

(setq backup-by-copying t
      create-lockfiles nil
      backup-directory-alist '((".*" . "~/.saves"))
      ;; auto-save-file-name-transforms `((".*" "~/.saves" t))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; ===== Midnight mode =====

;; Kills inactive buffers (three days of non-use)

(use-package midnight)

;; ===== Magit =====

(use-package magit
  :init (setq magit-completing-read-function 'ivy-completing-read)
  :bind
  ("<f5>" . magit-status)
  ("C-c v t" . magit-status))

;; ====== Hydra =======

(use-package hydra
  :ensure t
  :init
  (setq hydra-is-helpful t)
  
  :config
  (require 'hydra-ox))

;; ===== Keybindings ====== 

;; M-x describe-personal-keybindings to see personal customizations!

(use-package bind-key
  :bind ("C-h B" . describe-personal-keybindings))

;; ===== Unicode treatment ======

(set-language-environment "UTF-8")
(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; ===== Theme management ======

;; Set themes index
(setq owl/themes '(flatui-dark flatui doom-peacock doom-tomorrow-night cyberpunk doom-one-light leuven eink))
(setq owl/themes-index 0)

;; Function to cycle through themes
(defun owl/cycle-theme ()
  (interactive)
  (setq owl/themes-index (% (1+ owl/themes-index) (length owl/themes)))
  (owl/load-indexed-theme))

(global-set-key (kbd "<f12>") 'owl/cycle-theme)

;; Load indexed theme and disable previous theme to prevent overlay
(defun owl/load-indexed-theme ()
  (owl/try-load-theme (nth owl/themes-index owl/themes)))

(defun owl/try-load-theme (theme)
  (if (ignore-errors (load-theme theme :no-confirm))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))

;; ===== Font management and appearance =====

;; Turn on font-lock everywhere
(global-font-lock-mode t)

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

;; Control-c + Control-f/v to change font type: for writing
(bind-keys ("C-c C-f" . my-buffer-face-mode-fixed)
	   ("C-c C-v" . my-buffer-face-mode-variable))

;; Control-c + Control+Arrows to change font size
(bind-keys ("C-c C-<up>" . text-scale-increase)
	   ("C-c C-<down>" . text-scale-decrease))

;; Hydra to zoom text
(defhydra hydra-zoom (global-map "<f6>")
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out") 
  ("r" (text-scale-set 0) "reset")
  ("0" (text-scale-set 0) :bind nil :exit t)
  ("1" (text-scale-set 0) nil :bind nil :exit t))

;; ===== Visual appearance and behaviors ======

(auto-fill-mode -1)             ;; Disprefer auto-fill-mode
(show-paren-mode 1)             ;; Highlight parentheses
(setq show-paren-style 'mixed)  ;; Alternatives: 'expression, 'parenthesis

;; Handle long lines by visual wrapping but no line-returns
(global-visual-line-mode 1)

;; Change cursor shape
(setq-default cursor-type 'box)

;; Show lines and column numbers
(line-number-mode 1)
(column-number-mode 1)

;; End annoying buffers with popwin
(use-package popwin
  :ensure t
  :config
  (popwin-mode 1))

(global-set-key (kbd "C-z") popwin:keymap)

;; | Key    | Command                               |
;; |--------+---------------------------------------|
;; | b      | popwin:popup-buffer                   |
;; | l      | popwin:popup-last-buffer              |
;; | o      | popwin:display-buffer                 |
;; | C-b    | popwin:switch-to-last-buffer          |
;; | C-p    | popwin:original-pop-to-last-buffer    |
;; | C-o    | popwin:original-display-last-buffer   |
;; | SPC    | popwin:select-popup-window            |
;; | s      | popwin:stick-popup-window             |
;; | 0      | popwin:close-popup-window             |
;; | f, C-f | popwin:find-file                      |
;; | e      | popwin:messages                       |
;; | C-u    | popwin:universal-display              |
;; | 1      | popwin:one-window                     |

(use-package aggressive-indent
  :config (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

;; Rainbow mode
;; When activated, all strings representing colors will
;; be highlighted with the color they represent.
(use-package rainbow-mode
  :ensure t)

;; Make cursor more invisible when moving over long distance
(use-package beacon
  :config
  (beacon-mode 1))

;; ===== Editing and writing =====

;; Visual undo 

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode t)
  :defer t
  :diminish ""
  :config
  (progn
    (define-key undo-tree-map (kbd "C-x u") 'undo-tree-visualize)
    (define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)))

;; Spell checking

(use-package flyspell-correct-ivy
  :ensure t
  :init
  (setq ispell-program-name (executable-find "hunspell")   ; Use hunspell
	ispell-dictionary "en_US"
	flyspell-correct-interface 'flyspell-correct-ivy
	ispell-local-dictionary-alist '("deutsch-hunspell"
					"[[:alpha:]]"
					"[^[:alpha:]]"
					"[']"
					t
					("-d" "de_DE")   ; Dictionary file name
					nil
					utf-8)
	ispell-local-dictionary-alist '("english-hunspell"
					"[[:alpha:]]"
					"[^[:alpha:]]"
					"[']"
					t
					("-d" "en_US")
					nil
					utf-8)))

(bind-key "C-c G"
	  (lambda ()
	    (interactive)
	    (ispell-change-dictionary "de_DE")
	    (flyspell-buffer)))

(bind-key "C-c E"
	  (lambda ()
	    (interactive)
	    (ispell-change-dictionary "en_US")
	    (flyspell-buffer))) 

(use-package flx)

;; Provide functions for working on lists
(use-package dash)
(use-package dash-functional)

;; ===== Pdf-tools =====

;; Thing is a toad to install
;; https://github.com/politza/pdf-tools
;; ~/builds/pdf-tools contains some necessary files

(use-package let-alist
  :ensure t)

(use-package tablist
  :ensure t)

;; Comment out this line if Emacs daemon won't start
(pdf-tools-install)

;; Interleave
(use-package interleave
  :ensure t)

;; ===== Literate programming ======

;; Outline-minor-mode key map
(define-prefix-command 'cm-map nil "Outline-")

;; Hide
(define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the top-level headings
(define-key cm-map "t" 'hide-body)         ; Hide everything but headings (all body lines)
(define-key cm-map "o" 'hide-other)        ; Hide other branches
(define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
(define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
(define-key cm-map "d" 'hide-subtree)      ; Hide everything in this entry and sub-entries

;; Show
(define-key cm-map "a" 'show-all)          ; Show (expand) everything
(define-key cm-map "e" 'show-entry)        ; Show this heading's body
(define-key cm-map "i" 'show-children)     ; Show this heading's immediate child sub-headings
(define-key cm-map "k" 'show-branches)     ; Show all sub-headings under this heading
(define-key cm-map "s" 'show-subtree)      ; Show (expand) everything in this heading & below

;; Move
(define-key cm-map "u" 'outline-up-heading)                ; Up
(define-key cm-map "n" 'outline-next-visible-heading)      ; Next
(define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
(define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
(define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
(global-set-key "\M-o" cm-map)

;; ===== Buffer navigation & Ivy =====

;; Bring Emacs path and shell path in line with each other

(use-package exec-path-from-shell
  :defer 10
  :config
  (exec-path-from-shell-initialize))

;; Direx
(use-package direx
  :ensure t
  :config
  (require 'direx)
  (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory))

;; Ivy
(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :bind
  (:map ivy-mode-map
	("C-'" . ivy-avy))
  :init
  (use-package counsel
    :ensure t)
  :config
  (ivy-mode 1)
  ;;*** Find file actions
  ;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
  (setq ivy-use-virtual-buffers t)
  ;; number of result lines to display
  (setq ivy-height 10)
  ;; does not count candidates
  (setq ivy-count-format "")
  ;; no regexp by default
  (setq ivy-initial-inputs-alist nil)
  ;; configure regexp engine
  (setq ivy-re-builders-alist
	;; allow input not in order
        '((t   . ivy--regex-ignore-order))))

(use-package ivy-hydra)

;; ===== Python ======

;; Python editing mode
(use-package elpy
  :config
  (elpy-enable))

;; ===== The weather =====
(use-package wttrin
  :ensure t
  :init
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
  (setq wttrin-default-cities '("San Diego" "Aix-en-Provence" "Olympia"
				"Seoul")))

;; ===== End matter

(provide 'global-settings)

;;; Local Variables:
;;; eval: (outline-minor-mode 1)
;;; outline-regexp: ";;\\*+\\|\\`"
;;; End:
