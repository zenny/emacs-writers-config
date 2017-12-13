;;; ====== Org-lmode configuration ======

(require 'org)
(require 'ox-latex)
(require 'org-inlinetask)
(require 'org-mouse)
(require 'org-agenda)
(require 'orca)
;;(require 'dash)
(require 'ox-tufte)

;; ===== Configuration of org-mode =====

;; Set default org directory
(setq org-directory "~/org")

;; Open organizer with global command
(global-set-key (kbd "C-c C-c o")
		(lambda () (interactive) (find-file "~/org/organizer.org")))

;; Make editing invisible regions smart
(setq org-catch-invisible-edits 'smart)

;; Allow lists with letters in them
(setq org-list-allow-alphabetical t)

;; Setup archive location in archive directory in current folder
(setq org-archive-lcoation "archive/%s_archive::")

;; ===== Speed commands ======

(setq org-todo-keywords '((sequence "TODO(t)" "|" "DONE(d)")))

(setq org-use-speed-commands t)

(add-to-list 'org-speed-commands-user (cons "P" 'org-set-property))
(add-to-list 'org-speed-commands-user (cons "d" 'org-deadine))

;; Mark a subtree
(add-to-list 'org-speed-commands-user (cons "m" 'org-mark-subtree))

;; Widen a subtree
(add-to-list 'org-speed-commands-user (cons "S" 'widen))

;; Kill a subtree
(add-to-list 'org-speed-commands-user (cons "k" (lambda ()
						  (org-mark-subtree)
						  (kill-region
						   (region-beginning)
						   (region-end)))))

;; Use UTF-8 characters for org bullets
(use-package org-bullets
  :ensure t
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

;; ====== Refiling setup =====

;; Refiling targets

(setq org-refile-targets '(("~/org/bugout.org" :maxlevel . 3)
			   ("~/org/food.org" :maxlevel . 3)
			   ("~/org/organizer.org" :maxlevel . 3)
			   ("~/org/music.org" :maxlevel . 3)
			   ("~/org/writing.org" :maxlevel . 3)))

;; Allow parent node creation
(setq org-refile-allow-creating-parent-nodes 'confirm)

;; ===== Agenda setup =====

;; Org files targeted for agenda
(setq org-agenda-files (quote ("~/org/organizer.org")))

;; Record time task is finished when set to DONE
(setq org-log-done 'time)

(setq org-upcoming-deadline '(:foreground "blue" :weight bold))

(add-to-list
 'org-agenda-custom-commands
 '("w" "Weekly Review"
   ( ;; deadlines
    (tags-todo "+DEADLINE<=\"<today>\""
	       ((org-agenda-overriding-header "Late Deadlines")))
    ;; scheduled  past due
    (tags-todo "+SCHEDULED<=\"<today>\""
	       ((org-agenda-overriding-header "Late Scheduled")))

    ;; now the agenda
    (agenda ""
	    ((org-agenda-overriding-header "Weekly agenda")
	     (org-agenda-ndays 7)
	     (org-agenda-tags-todo-honor-ignore-options t)
	     (org-agenda-todo-ignore-scheduled nil)
	     (org-agenda-todo-ignore-deadlines nil)
	     (org-deadline-warning-days 0)))
    ;; and last a global todo list
    (todo "TODO"))))

;; ====== Org habit ======

;;  Position the habit graph on the agenda to the right of the default
;(setq org-habit-graph-column 50)

(run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))

(require 'org-habit)

;; ===== Capture =====

(require 'org-protocol)

(setq org-default-notes-file (concat org-directory "/organizer.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates `(
			      ("p" "Protocol" entry
			       (file+headline ,org-default-notes-file "Captures")
			       "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
			      ("L" "Protocol Link" entry
			       (file+headline ,org-default-notes-file "Captures")
			       "* %? [[%:link][%:description]] \nCaptured On: %U")
			      ))

;; ===== Org ref ======

(use-package org-ref
  :ensure t
  :init
  :config)

;; ====== Orca ======

(setq orca-handler-list
      '((orca-handler-match-url
         "https://www.reddit.com/emacs/"
         "~/Dropbox/org/wiki/emacs.org"
         "Reddit")
        (orca-handler-match-url
         "https://emacs.stackexchange.com/"
         "~/Dropbox/org/wiki/emacs.org"
         "\\* Questions")
        (orca-handler-current-buffer
         "\\* Tasks")
        (orca-handler-file
         "~/Dropbox/org/ent.org"
         "\\* Articles")))

;; ====== Org babel ======

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

;; ===== Org-board =====

;; org-board is a bookmarking and web archival system for Emacs Org
;; mode, building on ideas from Pinboard <https://pinboard.in>.  It
;; archives your bookmarks so that you can access them even when
;; you're not online, or when the site hosting them goes down.
;; `wget' is used as a backend for archival, so any of its options
;; can be used directly from org-board.  This means you can download
;; whole sites for archival with a couple of keystrokes, while
;; keeping track of your archives from a simple Org file.

(use-package org-board
  :ensure t
  :init
  (global-set-key (kbd "C-c b") org-board-keymap)
  )


;; ===== Org-brain =====

(use-package org-brain
  :ensure t
  :init
  (setq org-brain-path "brain/")
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  )

;; Make org-settings visible for init and packages.el

(provide 'org-settings)

;; End of file

