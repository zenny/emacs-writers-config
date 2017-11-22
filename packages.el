;;; ====== Install and configure various emacs packages =====

(setq use-package-always-ensure t)

;; ====== General settings =======

(use-package global-settings
  :ensure nil
  :load-path emacs-main-dir
  :init (require 'global-settings)
  :bind
  ("C-x C-b" . ibuffer))

;; ===== Org mode =====

(use-package org-plus-contrib
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
   ("s-<SPC>" . org-mark-ring-goto)
   ("H-." . org-time-stamp-inactive)))

(use-package org-settings
  :ensure nil
  :load-path emacs-main-dir
  :bind
  ("s--" . org-subscript-region-or-point)
  ("s-=" . org-superscript-region-or-point)
  ("s-i" . org-italics-region-or-point)
  ("s-b" . org-bold-region-or-point)
  ("s-v" . org-verbatim-region-or-point)
  ("s-c" . org-code-region-or-point)
  ("s-u" . org-underline-region-or-point)
  ("s-+" . org-strikethrough-region-or-point)
  ("s-4" . org-latex-math-region-or-point)
  ("s-e" . ivy-insert-org-entity)
  :init
  (require 'org-settings))

;; ===== Easy Hugo ======

(use-package easy-hugo
  :ensure t
  :init
  (setq easy-hugo-basedir "~/workspace/")
  (setq easy-hugo-url "http://www.matthew-edward-adams.org")
  (setq easy-hugo-sshdomain "~/.ssh/config")
  (setq easy-hugo-root "~/linguistgate.github.io/")
  (setq easy-hugo-previewtime "300")
  (setq easy-hugo-default-ext ".org")
  :bind ( "C-c C-w" . easy-hugo) 
  )

;; ===== Ivy ======

;; (use-package swiper
;;   :bind
;;   ("C-s" . counsel-grep-or-swiper)
;;   :diminish ivy-mode
;;   :config
;;   (ivy-mode))

;; (use-package counsel
;;   :init
;;   (require 'ivy)
;;   (setq projectile-completion-system 'ivy)
;;   (setq ivy-use-virtual-buffers t)
;;   (define-prefix-command 'counsel-prefix-map)
;;   (global-set-key (kbd "H-c") 'counsel-prefix-map)

;;   ;; default pattern ignores order.
;;   (setf (cdr (assoc t ivy-re-builders-alist))
;; 	'ivy--regex-ignore-order)
;;   :bind
;;   (("M-x" . counsel-M-x)
;;    ("C-x b" . ivy-switch-buffer)
;;    ("C-x C-f" . counsel-find-file)
;;    ("C-h f" . counsel-describe-function)
;;    ("C-h v" . counsel-describe-variable)
;;    ("C-h i" . counsel-info-lookup-symbol)
;;    ("H-c r" . ivy-resume)
;;    ("H-c l" . counsel-load-library)
;;    ("H-c g" . counsel-git-grep)
;;    ("H-c a" . counsel-ag)
;;    ("H-c p" . counsel-pt))
;;   :diminish ""
;;   :config
;;   (progn
;;     (counsel-mode)

;;     (define-key ivy-minibuffer-map (kbd "M-<SPC>") 'ivy-dispatching-done)

;;     ;; C-RET call and go to next
;;     (define-key ivy-minibuffer-map (kbd "C-<return>")
;;       (lambda ()
;; 	"Apply action and move to next/previous candidate."
;; 	(interactive)
;; 	(ivy-call)
;; 	(ivy-next-line)))

;;     ;; M-RET calls action on all candidates to end.
;;     (define-key ivy-minibuffer-map (kbd "M-<return>")
;;       (lambda ()
;; 	"Apply default action to all candidates."
;; 	(interactive)
;; 	(ivy-beginning-of-buffer)
;; 	(loop for i from 0 to (- ivy--length 1)
;; 	      do
;; 	      (ivy-call)
;; 	      (ivy-next-line)
;; 	      (ivy--exhibit))
;; 	(exit-minibuffer)))

;;     ;; s-RET to quit
;;     (define-key ivy-minibuffer-map (kbd "s-<return>")
;;       (lambda ()
;; 	"Exit with no action."
;; 	(interactive)
;; 	(ivy-exit-with-action
;; 	 (lambda (x) nil))))

;;     (define-key ivy-minibuffer-map (kbd "?")
;;       (lambda ()
;; 	(interactive)
;; 	(describe-keymap ivy-minibuffer-map)))

;;     (define-key ivy-minibuffer-map (kbd "<left>") 'ivy-backward-delete-char)
;;     (define-key ivy-minibuffer-map (kbd "<right>") 'ivy-alt-done)
;;     (define-key ivy-minibuffer-map (kbd "C-d") 'ivy-backward-delete-char)))

;; ===== Elfeed for RSS feeds =====

(use-package elfeed
  :ensure t
  :bind ("C-x w" . elfeed)
  :init
  ;; URLs in no particular order
  (setq elfeed-use-curl t)
  (setq elfeed-feeds
        '(;; Blogs
          ("http://harryrschwartz.com/atom.xml" blog)
          ("http://zinascii.com/writing-feed.xml" blog)
          ("http://githubengineering.com/atom.xml" blog)
          ("http://blog.smola.org/rss" blog)
          ("http://briancarper.net/feed" blog)
          ("https://kotka.de/blog/index.rss" blog)
          ("http://fiftyfootshadows.net/feed/" blog)
          ("http://blag.xkcd.com/feed/" blog)
          ("http://youdisappear.net/files/page1.xml" blog music)
          ("http://normanmaurer.me/blog.atom" blog)
          ("http://blog.mikemccandless.com/feeds/posts/default" elasticsearch blog)
          ("http://lethain.com/feeds/all/" blog)
          ("http://whatthefuck.computer/rss.xml" blog)
          ("http://feeds.feedburner.com/jamesshelley" blog)
          ("http://www.marco.org/rss" blog)
          ("http://elliotth.blogspot.com/feeds/posts/default" blog)
          ("http://feeds.feedburner.com/Hyperbole-and-a-half" blog)
          ("http://lcamtuf.blogspot.com/feeds/posts/default" blog)
          ("http://blog.isabel-drost.de/index.php/feed" blog)
          ("http://feeds2.feedburner.com/CodersTalk" blog)
          ("http://feeds.feedburner.com/codinghorror/" blog)
          ("http://lambda-the-ultimate.org/rss.xml" blog)
          ("http://danluu.com/atom.xml" blog)
          ("http://ferd.ca/feed.rss" blog)
          ("http://blog.fsck.com/atom.xml" blog)
          ("http://jvns.ca/atom.xml" blog)
          ("http://newartisans.com/rss.xml" blog emacs)
          ("http://bling.github.io/index.xml" blog emacs)
          ("https://rachelbythebay.com/w/atom.xml" blog)
          ("http://blog.nullspace.io/feed.xml" blog)
          ("http://www.mcfunley.com/feed/atom" blog)
          ("https://codewords.recurse.com/feed.xml" blog)
          ("http://akaptur.com/atom.xml" blog)
          ("http://davidad.github.io/atom.xml" blog)
          ("http://www.evanjones.ca/index.rss" blog)
          ("http://neverworkintheory.org/feed.xml" blog)
          ("http://blog.jessitron.com/feeds/posts/default" blog)
          ("http://feeds.feedburner.com/GustavoDuarte?format=xml" blog)
          ("http://blog.regehr.org/feed" blog)
          ("https://www.snellman.net/blog/rss-index.xml" blog)
          ("http://eli.thegreenplace.net/feeds/all.atom.xml" blog)
          ("https://idea.popcount.org/rss.xml" blog)
          ("https://aphyr.com/posts.atom" blog)
          ("http://kamalmarhubi.com/blog/feed.xml" blog)
          ("http://maryrosecook.com/blog/feed" blog)
          ("http://www.tedunangst.com/flak/rss" blog)
          ("http://yosefk.com/blog/feed" blog)
          ("http://www.benkuhn.net/rss/" blog)
          ("https://emacsgifs.github.io/feed.xml" blog emacs)
          ("http://www.alfredodinapoli.com/rss.xml" blog)
          ("https://icosahedron.website/users/technomancy.atom" blog microblog)

          ;; Theology

          ;; Github feeds
          ("https://github.com/milkypostman/melpa/commits/master.atom" github emacs)
          ("https://github.com/elasticsearch/elasticsearch/commits/master.atom" github elasticsearch)
          ("https://github.com/aphyr/jepsen/commits/master.atom" github)

          ;; Linux
          ("http://www.phoronix.com/rss.php" linux news)
          ("http://fedoramagazine.org/feed/" linux)
          ("http://feeds.feedburner.com/mylinuxrig" linux)

          ;; Emacs
          ("http://oremacs.com/atom.xml" emacs)
          ("http://www.lunaryorn.com/feed.atom" emacs)
          ("http://emacsnyc.org/atom.xml" emacs)
          ("http://emacsredux.com/atom.xml" emacs)
          ("http://www.masteringemacs.org/feed/" emacs)
          ("http://planet.emacsen.org/atom.xml" emacs)
          ("http://endlessparentheses.com/atom.xml" emacs)

          ;; News
          ("http://feeds.arstechnica.com/arstechnica/index/" news)
          ("http://www.osnews.com/files/recent.xml" news)
          ("http://rss.slashdot.org/Slashdot/slashdot" news)
          ("http://feeds2.feedburner.com/boingboing/iBag" news)
          ("http://thefeature.net/rss" news)
          ("http://acculturated.com/feed/" news)
          ("https://opensource.com/feed" news)

          ;; Flickr

          ;; Reddit
          ("https://www.reddit.com/r/emacs/.rss" emacs reddit)
          ("https://www.reddit.com/r/orgmode/.rss" emacs reddit)
          ("https://www.reddit.com/r/elasticsearch/.rss" elasticsearch reddit)
          ("https://www.reddit.com/r/elastic/.rss" elasticsearch reddit)

          ;; Other

	  
          ))
  :config
  (define-key elfeed-show-mode-map (kbd "j") 'next-line)
  (define-key elfeed-show-mode-map (kbd "k") 'previous-line))


;; ===== The weather =====

(use-package wttrin
  :ensure t
  :init
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))
  (setq wttrin-default-cities '("San Diego" "Aix-en-Provence" "Olympia"
				"Seoul")))

;; ===== Other packages ======


(use-package aggressive-indent
  :config (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(use-package auto-complete
  :diminish auto-complete-mode
  :config (ac-config-default))

;; Make cursor more invisible when moving over long distance
(use-package beacon
  :config
  (beacon-mode 1))

;; Provide functions for working on lists
(use-package dash)
(use-package dash-functional)

;; Python editing mode
(use-package elpy
  :config
  (elpy-enable))

(provide 'packages)

;; packages.el ends here
