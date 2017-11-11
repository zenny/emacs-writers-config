;;; ====== Org-mode configuration ======

(require 'org)
(require 'ox-latex)
(require 'org-inlinetask)
(require 'org-mouse)
;(require 'org-ref)
(require 'org-agenda)
;(require 'dash)

;; ===== Configuration of org-mode =====

;; Open organizer with global command
(global-set-key (kbd "C-c C-o")
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

(provide 'org-settings)

;; End of file

