;;; firefox-controller-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "firefox-controller" "firefox-controller.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from firefox-controller.el

(autoload 'firefox-controller-remote-mode "firefox-controller" "\
Enter `firefox-controller-remote-mode'.

\(fn)" t nil)

(autoload 'firefox-controller-direct-mode "firefox-controller" "\
Enter `firefox-controller-direct-mode'.

\(fn)" t nil)

(autoload 'firefox-controller-send-key-sequence "firefox-controller" "\
Send keys specified by KEY-SEQ-STR to firefox.

\(fn KEY-SEQ-STR)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "firefox-controller" '("firefox-controller-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; firefox-controller-autoloads.el ends here
