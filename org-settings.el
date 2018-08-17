;;; ====== Org-mode settings ======

(use-package org
  :ensure org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  :init
  ;; Use the current window for C-c ' source editing
  (setq org-src-window-setup 'current-window
	org-support-shift-select t)
  (setq org-return-follows-link t)
  :bind
  (("C-c l" . org-store-link)
   ("C-c L" . org-insert-link-global)
   ("C-c o" . org-open-at-point-global)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c w" . org-refile)
   ("s-<SPC>" . org-mark-ring-goto)
   ("H-." . org-time-stamp-inactive))
  :config

  ;; Set default org directory
  (setq org-directory "~/org")

  ;; Default org file aps
  (setq org-file-apps
	'(("\\.docx\\'" . default)
	  ("\\.mm\\'" . default)
	  ("\\.x?html?\\'" . default)
	  ("\\.pdf\\'" . default)
	  (auto-mode . emacs)))

  ;; Make org-mode aware of pdf-tools
  (use-package org-pdfview
    :ensure t)

  (eval-after-load 'org '(require 'org-pdfview))

  (add-to-list 'org-file-apps 
               '("\\.pdf\\'" . (lambda (file link)
				 (org-pdfview-open link))))
  ;; Custom key bindings
  (global-set-key (kbd "C-c C-x o")
		  (lambda () (interactive) (find-file "~/org/organizer.org")))
  (global-set-key (kbd "<f9> c") 'calendar)
  (global-set-key (kbd "<f9> m") 'gnus)

  ;; Org-mouse 
  ;;(quelpa '(org-mouse :fetcher github :repo "takaxp/org-mode"))

  ;;(require 'org-mouse)

  ;; Make editing invisible regions smart
  (setq org-catch-invisible-edits 'smart)

  ;; Allow lists with letters in them
  (setq org-list-allow-alphabetical t)

  ;; Setup archive location in archive directory in current folder
  (setq org-archive-lcoation "/archive/%s_archive::")

  ;;* ===== Custom IDs behavior =====

  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

  ;; Update ID file on startup
  (org-id-update-id-locations)

  ;; ===== Speed commands and inline tasks ======

  (use-package org-inlinetask
    :ensure org-plus-contrib
    :bind (:map org-mode-map ("C-c C-x t" . org-inlinetask-insert-task))
    :after (org)
    :commands (org-inlinetask-insert-task)
    )

  (setq org-todo-keywords '((sequence "IDEA(i)")
			    (sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)" "|" "DONE(d)")
			    (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)")))

  (setq org-enforce-todo-dependencies t)

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


  (require 'org-checklist)

  ;; ===== Org-download =====

  ;; For picture management, drag-and-drop ability
  ;; https://github.com/abo-abo/org-download/blob/master/org-download.el

  (use-package org-download
    :ensure t
    :config
    (setq-default org-download-image-dir "~/org/img")
    )

  ;; ===== Contact management =====

  ;; BBDB
  (use-package bbdb
    :ensure t
    :init
    (bbdb-initialize)
    (bbdb-insinuate-message)
    :config
    (setq bbdb-file "~/org/contacts/bbdb")
    )

  ;; ===== Agenda setup =====

  (use-package org-agenda
    :ensure org-plus-contrib
    :init
    ;; Org files targeted for agenda
    (setq org-agenda-files (quote ("~/org/organizer.org"
				   "~/areas/food/food.org"
				   "~/org/reading.org"
				   "~/org/writing.org"
				   "~/org/notebook/notebook.org")))
    
    ;; Record time task is finished when set to DONE
    (setq org-log-done 'time)
    (setq org-upcoming-deadline '(:foreground "blue" :weight bold))
    :config

    ;; Org-super-agenda
    (use-package org-super-agenda
      :ensure t
      :config
      (setq my-super-agenda-groups
	    '(
	      (:name "Today" :time-grid t :todo "TODAY")
	      (:name "DEADLINES" :deadline t :order 1)
	      (:name "Important" :priority "A" :order 2)
	      )
	    )
      (defun my-super-agenda()
	"generates my super-agenda"
	(interactive)
	(org-super-agenda-mode)
	(let
	    ((org-super-agenda-groups my-super-agenda-groups))
	  (org-agenda nil "a")
	  )
	)
      )

    ;; Provides unscheduled tasks
    (defun owl/org-agenda-skip-scheduled ()
      (org-agenda-skip-entry-if 'scheduled 'deadline 'regexp "\n]+>"))
    )


  
  ;; Agenda views

  ;; (add-to-list
  ;;  'org-agenda-custom-commands
  ;;  '("w" "Weekly Review"
  ;;    ( ;; deadlines
  ;;     (tags-todo "+DEADLINE<=\"<today>\""
  ;; 	       ((org-agenda-overriding-header "Late Deadlines")))
  ;;     ;; scheduled  past due
  ;;     (tags-todo "+SCHEDULED<=\"<today>\""
  ;; 	       ((org-agenda-overriding-header "Late Scheduled")))

  ;;     ;; now the agenda
  ;;     (agenda ""
  ;; 	    ((org-agenda-overriding-header "Weekly agenda")
  ;; 	     (org-agenda-ndays 7)
  ;; 	     (org-agenda-tags-todo-honor-ignore-options t)
  ;; 	     (org-agenda-todo-ignore-scheduled nil)
  ;; 	     (org-agenda-todo-ignore-deadlines nil)
  ;; 	     (org-deadline-warning-days 0)))
  ;;     ;; and last a global todo list
  ;;     (todo "TODO"))))

  ;; (add-to-list 'org-agenda-custom-commands
  ;; 	     '("u" "Unscheduled tasks" alltodo ""
  ;; 	       ((org-agenda-skip-function 'sacha/org-agenda-skip-scheduled)
  ;; 		(org-agenda-overriding-header "Unscheduled TODO entries: "))))

  ;; ====== Org habit ======

  ;;  Position the habit graph on the agenda to the right of the default
					;(setq org-habit-graph-column 50)

  (run-at-time "06:00" 86400 '(lambda () (setq org-habit-show-habits t)))

  (use-package org-habit
    :ensure org-plus-contrib)

  ;;* ===== Capture =====

  (require 'org-protocol)

  (setq org-default-notes-file (concat org-directory "/organizer.org"))
  (define-key global-map "\C-cc" 'org-capture)

  (setq org-capture-templates `(("t"                                                                         ; key
				 "todo"                                                                      ; description
				 entry                                                                       ; type
				 (file+headline ,org-default-notes-file "Deck")                              ; target
				 "* TODO [#B] %^{Todo} \n:LOGBOOK:\n:CREATED: %U\n:END:"  ; template
				 :prepend nil          ; properties
				 :empty-lines 0        ; properties
				 :created t            ; properties
				 )
				("n"
				 "note"
				 entry
				 (file+headline ,org-default-notes-file "Notes")
				 "* %? :NOTE:\n:LOGBOOK:\n:CREATED: %U\n:END:"
				 :prepend nil
				 :empty-lines 0
				 :created t
				 )
				("j"
				 "notebook entry"
				 entry
				 (file+datetree "~/org/notebook/notebook.org")
				 "* %?"
				 :empty-lines 1
				 )
				("r"
				 "recipe"
				 entry
				 (file+headline "~/org/food.org" "Recipes")
				 "* TOCOOK %?\n:LOGBOOK:\n:CREATED: %U\n:END:\n:PROPERTIES:\n:SOURCE: \n:SERVES: \n:END:\n** Ingredients\n** Preparation"
				 :prepend nil
				 :empty-lines 0
				 :created t
				 )				
				("e"
				 "elfeed"
				 entry
				 (file "~/org/captures/captures.org")
				 "* %a  %^G \n:LOGBOOK:\n:CAPTURED: %U\n:END:\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n" 
				 :prepend nil
				 :empty-lines 0
				 :created t
				 )
				("p" "Protocol" entry (file "~/org/captures/captures.org")
				 "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
				("L" "Protocol Link" entry (file "~/org/captures/captures.org")
				 "* %? [[%:link][%:description]] \nCaptured On: %U")				
				))

  ;; (defun owl/elfeed-entry-as-html-link ()
  ;;   "Store an http link to an elfeed entry"
  ;;   (when (equal major-mode 'elfeed-show-mode)
  ;;     (let ((description (elfeed-entry-title elfeed-show-entry))
  ;; 	    (link (elfeed-entry-link elfeed-show-entry)))
  ;; 	(org-store-link-props
  ;; 	 :type "http"
  ;; 	 :link link
  ;; 	 :description description))))

  ;; (add-hook 'org-store-link-functions 'owl/elfeed-entry-as-html-link)
  
  ;; (defun do-org-board-dl-hook ()
  ;;   (when (equal (buffer-name)
  ;; 		 (concat "CAPTURE-" org-board-capture-file))
  ;;     (org-board-archive)))

  ;; (add-hook 'org-capture-before-finalize-hook 'do-org-board-dl-hook)

  ;;* ====== Refiling setup =====

  ;; Refiling targets

  ;; Allow top-level refiling
  ;; See https://blog.aaronbieber.com/2017/03/19/organizing-notes-with-refile.html
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)

  ;; Allow on-the-fly creation of parent headings
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  
  (setq org-refile-targets '(("~/org/organizer.org" :maxlevel . 5)
			     ("~/org/captures.org" :maxlevel . 5)
			     ("~/org/areas/food/food.org" :maxlevel . 5)
			     ("~/org/areas/freelance/freelance.org" :maxlevel . 5)
			     ("~/org/areas/reading.org" :maxlevel . 5)
			     ("~/org/areas/teaching.org" :maxlevel . 5)
			     ("~/org/areas/writing.org" :maxlevel . 5)
			     ("~/org/projects/ettelon/ettelon.org" :maxlevel . 5)
			     ("~/org/resources/notes/music.org" :maxlevel . 5)
			     ("~/org/resources/notes/library.org" :maxlevel . 5)
			     ("~/org/resources/notes/reference.org" :maxlevel . 8)
			     ("~/org/resources/notes/survival.org" :maxlevel . 5)
			     ))
  
  ;;* ===== Reading list managmeent ======

  ;; Uses code from https://github.com/lepisma/org-books to create reading tracking.

  (use-package org-books
    :ensure nil
    :load-path "org-books/"
    :init
    (use-package enlive
      :ensure t)
    :config
    (setq org-books-file "~/org/library.org")
    )

  ;;* ====== Orca ======

  (require 'orca)

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

  ;;* ====== Org babel ======

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
           (shell . t)
           (ledger . t)
           (org . t)
           (plantuml . t)
           (latex . t))))

  ;;* ===== Org-board =====

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

  ;;* ===== Org-brain =====

  (use-package org-brain
    :ensure t
    :init
    (setq org-brain-path "notebook/brain/")
    :config
    (setq org-id-track-globally t)
    (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
    (push '("b" "Brain" plain (function org-brain-goto-end)
            "* %i%?" :empty-lines 1)
          org-capture-templates)
    (setq org-brain-visualize-default-choices 'all)
    (setq org-brain-title-max-length 12)
    )

  ;; ===== Org-drill =====

  (use-package org-drill
    :ensure nil
    :load-path "~/.emacs.d/org-drill/org-drill.el"
    ;;:quelpa (org-drill :stable nil :fetcher file :path "~/.emacs.d/org-drill/org-drill.el")
    )

  (use-package org-drill-table
    :ensure nil
    :load-path "~/.emacs.d/org-drill-table/org-drill-table.el"
    ;;(quelpa '(org-drill-table :fetcher file :path "~/.emacs.d/org-drill-table/org-drill-table.el"))
    )

  ;; ===== Org-wiki =====

  (add-to-list 'load-path (expand-file-name "org-wiki" emacs-main-dir))
  (require 'org-wiki)

  ;; Paths to Wiki locations
  (setq org-wiki-location-list
	'(
	  "~/org/notebook/wiki"
	  "~/projects/ettelon/wiki)"
	  ))

  ;; (setq org-wiki-template
  ;;       (string-trim
  ;;        "
  ;; #+TITLE: %n
  ;; #+DESCRIPTION:
  ;; #+KEYWORDS:
  ;; #+STARTUP:  content
  ;; #+DATE: %d

  ;; - [[wiki:index][Index]]

  ;; - Related: 

  ;; * %n
  ;; "))

  ;;* ===== Org ref ======

  (use-package org-ref
    :ensure t)

  (use-package ebib
    :ensure t)

  ;;* ===== Publishing =====

  (require 'ox-latex)
  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil))

  ;; (with-eval-after-load 'ox-latex
  ;;   (add-to-list
  ;;    'org-latex-classes
  ;;    '(("tufte-simplified"
  ;; 	"\\documentclass[a4paper, sfsidenotes, justified, notitlepage]{book}
  ;;    \\input{/home/owl/.emacs.d/user/tufte-simplified/tufte-simplified.cls}"
  ;; 	("\\part{%s}" . "\\part*{%s}")
  ;; 	("\\chapter{%s}" . "\\chapter*{%s}")
  ;; 	("\\section{%s}" . "\\section*{%s}")
  ;; 	("\\subsection{%s}" . "\\subsection*{%s}")))))


  ;; This package converts the buffer text and the associated
  ;; decorations to HTML. Mail to hniksic@gmail.com to discuss features
  ;; and additions. All suggestions are more than welcome.
  (use-package htmlize
    :ensure t)

  (use-package ox-gfm
    :ensure t)

  ;;** Org-Tufte integration

  (require 'ox-tufte)

  (use-package ox-tufte-latex
    :ensure nil
    :load-path "tufte-org-mode/"
    )

  ;; (add-to-list 'load-path (expand-file-name "tufte-org-mode" emacs-main-dir))
  ;; (require 'ox-tufte-latex)
  (require 'ox-extra)

  ;; Publish ~/org to ~/org-html as HTML
  (setq org-publish-project-alist
	'(("org-central"
           :base-directory "~/org/"
           :publishing-directory "~/private-html/"
           :publishing-function org-html-publish-to-html
           :section-numbers nil
	   :recursive nil
           :with-toc nil 
           :html-head "<link rel=\"stylesheet\"
                    href=\"./css/org.css\"
                    type=\"text/css\"/>")
	  ("org-notebook"
           :base-directory "~/org/notebook"
           :publishing-directory "~/private-html/"
           :publishing-function org-html-publish-to-html
           :section-numbers nil
	   :recursive nil
           :with-toc t 
           :html-head "<link rel=\"stylesheet\"
                    href=\"./css/tufte.css\"
                    type=\"text/css\"/>")
	  ("org-static"
	   :base-directory "~/org/img/"
	   :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	   :publishing-directory "~/private-html/img/"
	   :recursive t
	   :publishing-function org-publish-attachment
	   )
	  ("org-notebook-static"
	   :base-directory "~/org/notebook/img/"
	   :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	   :publishing-directory "~/private-html/notebook/img/"
	   :recursive t
	   :publishing-function org-publish-attachment
	   )
	  ("org" :components ("org-notes" "org-static"))
	  ))
  
  ;; ====== End of :config ======
  
  ) ; closing parens for use-package org

;; Make org-settings visible for init and packages.el

  (provide 'org-settings)

  ;; End of file

