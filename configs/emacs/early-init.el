;;; early-init.el --- -*- lexical-binding: t; -*-

;;; Code:

;; Disable GUI elements I don't use.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Get rid of splash screen.
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message user-login-name) ;; Read docstring.
(setq inhibit-startup-screen t)
(setq inhibit-startup-buffer-menu nil)
(setq initial-scratch-message nil)
(advice-add #'display-startup-echo-area-message :override #'ignore)

;; Increase garbage collection threshold - has some performance benefit.
(setq gc-cons-threshold (* 50 1024 1024)) ;; 50mb

;; Useful for dealing with language servers using eglot.
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; Inhibit frame resize - has some performance benefit.
(setq frame-inhibit-implied-resize t)

;; Use y/n responses to yes/no prompts.
(fset 'yes-or-no-p 'y-or-n-p)

;; Native compilation settings
(when (and (fboundp 'native-comp-available-p)
           (native-comp-available-p))
  ;; Suppress annoying native compilation warnings.
  (setq native-comp-async-report-warnings-errors 'silent)
  (setq native-comp-deferred-compilation t))

;; Set driver options for native compilation if using MacOS.
(when (eq system-type 'darwin)
  (setq native-comp-driver-options '("-Wl,-w")))

(provide 'early-init)
;;; early-init.el ends here
