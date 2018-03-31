;;; magithub-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "magithub" "magithub.el" (23064 30140 877443
;;;;;;  482000))
;;; Generated autoloads from magithub.el
 (autoload 'magithub-dispatch-popup "magithub" nil t)

;;;***

;;;### (autoloads nil "magithub-comment" "magithub-comment.el" (23064
;;;;;;  30140 885443 439000))
;;; Generated autoloads from magithub-comment.el

(autoload 'magithub-comment-new "magithub-comment" "\
Comment on ISSUE in a new buffer.

\(fn ISSUE)" t nil)

;;;***

;;;### (autoloads nil "magithub-dash" "magithub-dash.el" (23064 30140
;;;;;;  913443 289000))
;;; Generated autoloads from magithub-dash.el

(autoload 'magithub-dashboard "magithub-dash" "\
View your GitHub dashboard.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "magithub-edit-mode" "magithub-edit-mode.el"
;;;;;;  (23064 30140 853443 611000))
;;; Generated autoloads from magithub-edit-mode.el

(autoload 'magithub-edit-mode "magithub-edit-mode" "\
Major mode for editing GitHub issues and pull requests.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "magithub-issue-tricks" "magithub-issue-tricks.el"
;;;;;;  (23064 30140 913443 289000))
;;; Generated autoloads from magithub-issue-tricks.el

(autoload 'magithub-pull-request-merge "magithub-issue-tricks" "\
Merge PULL-REQUEST with ARGS.
See `magithub-pull-request--completing-read'.  If point is on a
pull-request object, that object is selected by default.

\(fn PULL-REQUEST &optional ARGS)" t nil)

;;;***

;;;### (autoloads nil "magithub-issue-view" "magithub-issue-view.el"
;;;;;;  (23064 30140 893443 397000))
;;; Generated autoloads from magithub-issue-view.el

(autoload 'magithub-issue-view "magithub-issue-view" "\
View ISSUE in a new buffer.

\(fn ISSUE)" t nil)

;;;***

;;;### (autoloads nil nil ("magithub-ci.el" "magithub-core.el" "magithub-faces.el"
;;;;;;  "magithub-issue-post.el" "magithub-issue.el" "magithub-label.el"
;;;;;;  "magithub-notification.el" "magithub-orgs.el" "magithub-pkg.el"
;;;;;;  "magithub-proxy.el" "magithub-repo.el" "magithub-user.el")
;;;;;;  (23064 30140 921443 246000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; magithub-autoloads.el ends here
