;; ===== Web and blogging settings =====

(use-package eww
  :defer t
  :init
  (setq browse-url-browser-function
        '((".*google.*maps.*" . browse-url-generic)
          ;; Github goes to firefox, but not gist
	  ("amazon.com" . browse-url-generic)
          ("http.*\/\/github.com" . browse-url-generic)
          ("groups.google.com" . browse-url-generic)
          ("docs.google.com" . browse-url-generic)
          ("melpa.org" . browse-url-generic)
          ("build.*\.elastic.co" . browse-url-generic)
          (".*-ci\.elastic.co" . browse-url-generic)
          ("internal-ci\.elastic\.co" . browse-url-generic)
          ("zendesk\.com" . browse-url-generic)
          ("salesforce\.com" . browse-url-generic)
          ("stackoverflow\.com" . browse-url-generic)
          ("apache\.org\/jira" . browse-url-generic)
          ("thepoachedegg\.net" . browse-url-generic)
          ("zoom.us" . browse-url-generic)
          ("t.co" . browse-url-generic)
          ("twitter.com" . browse-url-generic)
          ("\/\/a.co" . browse-url-generic)
          ("youtube.com" . browse-url-generic)
          ("." . eww-browse-url)))
  (setq shr-external-browser 'browse-url-generic)
  (setq browse-url-generic-program (executable-find "firefox"))
  (add-hook 'eww-mode-hook #'toggle-word-wrap)
  (add-hook 'eww-mode-hook #'visual-line-mode)
  :config
  (use-package s :ensure t)
  (define-key eww-mode-map "o" 'eww)
  (define-key eww-mode-map "O" 'eww-browse-with-external-browser)
  (define-key eww-mode-map "j" 'next-line)
  (define-key eww-mode-map "k" 'previous-line)

  (use-package eww-lnum
    :ensure t
    :config
    (bind-key "f" #'eww-lnum-follow eww-mode-map)
    (bind-key "U" #'eww-lnum-universal eww-mode-map)))

;; Link hints!

(use-package link-hint  
  :ensure t
  :bind ("C-c f" . link-hint-open-link))

;; Search backwards, prompting to open any URL found

(defun browse-last-url-in-brower ()
  (interactive)
  (save-excursion
    (ffap-next-url t t)))

(global-set-key (kbd "C-c u") 'browse-last-url-in-brower)

;; ===== Easy Hugo ======

(use-package easy-hugo
  :ensure t
  :init
  (setq easy-hugo-basedir "~/public_workspace")
  (setq easy-hugo-postdir "content/posts")
  (setq easy-hugo-url "http://www.matthew-edward-adams.org")
  (setq easy-hugo-sshdomain "~/.ssh/config")
  (setq easy-hugo-root "~/public_workspace")
  (setq easy-hugo-previewtime "300")
  (setq easy-hugo-default-ext ".org")
  :bind ( "C-c C-n p" . easy-hugo)
  )

;; ===== Elfeed for RSS feeds =====

(use-package elfeed
  :ensure t
  :bind ("C-x w" . elfeed)
  :init
  (setq elfeed-use-curl t)
  (use-package elfeed-org
    :ensure t
    :init 
    (setq rmh-elfeed-org-files (list "~/org/elfeed.org"))
    )
  :config
  (define-key elfeed-show-mode-map (kbd "j") 'next-line)
  (define-key elfeed-show-mode-map (kbd "k") 'previous-line)
  ;(use-package elfeed-goodies :ensure t :init (use-package ace-jump-mode :ensure t))
  (use-package elfeed-web
    :ensure t
    )
  ;; org-capture for Elfeed
  (defun owl/org-elfeed-entry-store-link ()
    (when elfeed-show-entry
      (let* ((link (elfeed-entry-link elfeed-show-entry))
             (title (elfeed-entry-title elfeed-show-entry)))
	(org-store-link-props
	 :link link
	 :description title)
	)))

  (add-hook 'org-store-link-functions
            'owl/org-elfeed-entry-store-link)

  ;; Browse article in gui browser instead of eww
  ;; http://pragmaticemacs.com/emacs/to-eww-or-not-to-eww/
  (defun owl/elfeed-show-visit-gui ()
    "Wrapper for elfeed-show-visit to use Firefox instead of eww"
    (interactive)
    (let ((browse-url-generic-program "/usr/bin/firefox"))
      (elfeed-show-visit t)))

  (define-key elfeed-show-mode-map (kbd "B") 'owl/elfeed-show-visit-gui)

  ) ;; Closing use-package

;; Stack Exchange client
(use-package sx
  :ensure t)

(provide 'web-settings)

;; end of file
