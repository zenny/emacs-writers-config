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

(use-package hydra
  :ensure t
  :init
  (setq hydra-is-helpful t)
  :config
  (require 'hydra-ox))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode)
  (which-key-setup-side-window-right-bottom)
  (setq which-key-max-description-length 60))

(use-package helpful
  :bind
  ("C-h f" . helpful-function)
  ("C-h x" . helpful-command)
  ("C-h z" . helpful-macro))

;; Answer with y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(use-package auto-complete
  :diminish auto-complete-mode
  :config (ac-config-default))

;; See http://bnbeckwith.com/bnb-emacs/ for supercharged variant on C-x o traversal:
(use-package ace-window
  :ensure t
  :bind
  ("<f9> a" . ace-window)
  :config
  (setq aw-keys '(?j ?k ?l ?n ?m)
        aw-leading-char-style 'path
        aw-dispatch-always t
        aw-dispatch-alist
        '((?x aw-delete-window "Ace - Delete Window")
          (?c aw-swap-window   "Ace - Swap window")
          (?n aw-flip-window   "Ace - Flip window")
          (?v aw-split-window-vert "Ace - Split Vert Window")
          (?h aw-split-window-horz "Ace - Split Horz Window")
          (?m delete-other-windows "Ace - Maximize Window")
          (?b balance-windows)))

  (defhydra hydra-window-size (:color amaranth)
    "Window size"
    ("h" shrink-window-horizontally "shrink horizontal")
    ("j" shrink-window "shrink vertical")
    ("k" enlarge-window "enlarge vertical")
    ("l" enlarge-window-horizontally "enlarge horizontal")
    ("q" nil "quit"))
  (add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)

  (defhydra hydra-window-frame (:color red)
    "Frame"
    ("f" make-frame "new frame")
    ("x" delete-frame "delete frame")
    ("q" nil "quit"))
  (add-to-list 'aw-dispatch-alist '(?\; hydra-window-frame/body) t)

  (defhydra hydra-window-scroll (:color amaranth)
    "Scroll other window"
    ("n" scroll-other-window "scroll")
    ("p" scroll-other-window-down "scroll down")
    ("q" nil "quit"))
  (add-to-list 'aw-dispatch-alist '(?o hydra-window-scroll/body) t)

  (set-face-attribute 'aw-leading-char-face nil :height 2.0))

;; ====== Emacs string manipulation library ======

(use-package s
  :ensure t)

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

;; ===== Keybindings ====== 

;; M-x describe-personal-keybindings to see personal customizations!

(use-package bind-key
  :bind ("C-h B" . describe-personal-keybindings))

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

(use-package all-the-icons
  :ensure t
  :defer 10)

;; Unicode treatment

(set-language-environment "UTF-8")
(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; ===== Language support =====

;; Input methods

;; Toggle among them WIHTOUT use of external input method switchers (e.g., IBus or Nabi)

;; Korean

(set-fontset-font t 'hangul (font-spec :name "NanumMyeongjo-16"))

;; German

;; Spanish

;; ===== Visual appearance and behaviors ======

(use-package pretty-mode
  :disabled
  :config
  (global-pretty-mode t)
  (pretty-activate-groups
   '(:sub-and-superscripts :greek :arithmetic-nary)))

(scroll-bar-mode -1)            ;; Removes scroll bars

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
  :init
  (global-set-key (kbd "C-z") popwin:keymap)
  :config
  (popwin-mode 1)
  )

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

(use-package ace-flyspell
  :ensure t
  :commands (ace-flyspell-setup)
  :bind
  ("<f7> s" . hydra-fly/body)
  :init
  (add-hook 'flyspell-mode-hook 'ace-flyspell-setup)
  (defhydra hydra-fly (:color pink)
    ("n" flyspell-goto-next-error "Next error")
    ("c" ispell-word "Correct word")
    ("j" ace-flyspell-jump-word "Jump word")
    ("." ace-flyspell-dwim "dwim")
    ("q" nil "Quit")))

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

;; ===== Programming ======

;; Project management

;; Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;; ===== Navigation =====

;; NeoTree
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :bind ("<f8>" . neotree-toggle)
  :config
  ;; Every time when the neotree window is opened, let it find current file and jump to node
  (setq neo-smart-open t)
  ;; Popwin -- currently warning about void with neo-persist-show 2018-07-19
  ;; (when neo-persist-show
  ;;   (add-hook 'popwin:before-popup-hook
  ;; 	      (lambda () (setq neo-persist-show nil)))
  ;;   (add-hook 'popwin:after-popup-hook
  ;; 	      (lambda () (setq neo-persist-show t)))
  ;;   )
  )

;; Use IBuffer

(bind-key "C-x C-b" 'ibuffer)

(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "Standard")))

(setq ibuffer-saved-filter-groups
      '(("Standard"
         ("Emacs" (mode . emacs-lisp-mode))
         ("Org" (mode . org-mode))
         ("Magit" (name . "\*magit"))
         ("Mail" (or (mode . message-mode)
                     (mode . mail-mode)))
         ("HTML" (mode . html-mode))
         ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*"))))))

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
