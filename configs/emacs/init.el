;;; init.el --- -*- lexical-binding: t; -*-

;;; Code:

;; Name and email.
(setq user-full-name "Ahnaf Rafi")
(setq user-mail-address "ahnaf.al.rafi@gmail.com")

;; Set file for custom.el to use --- I use this for temporary customizations.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; Load the custom file.
(load custom-file 'noerror 'nomessage)

;; Add user lisp directory to load path.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Clipboard/kill-ring --- do not keep duplicates.
(setq kill-do-not-save-duplicates t)

;; Disable the alarm bell
(setq ring-bell-function 'ignore)

;; For mouse events
(setq use-dialog-box nil)
(setq use-file-dialog nil)

;; Disable backups and lockfiles
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; Enable auto-saves
(setq auto-save-default t)

;; Auto-save transforms
(setq auto-save-file-name-transforms
      (list (list "\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'"
                  ; Prefix tramp auto-saves to prevent conflicts
                  (concat auto-save-list-file-prefix "tramp-\\2") t)
            (list ".*" auto-save-list-file-prefix t)))

(setq use-package-always-ensure t)
(setq use-package-always-defer t)

(require 'use-package)

(use-package gcmh
  :init
  (setq gcmh-idle-delay 5)
  (setq gcmh-high-cons-threshold (* 100 1024 1024))
  (setq gcmh-verbose init-file-debug)
  (gcmh-mode 1))

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))

(add-to-list 'default-frame-alist '(font . "JuliaMono-14.0"))
(set-face-attribute 'default nil :font "JuliaMono-14.0")

(use-package nerd-icons)

;; Dealing with Xressources - i.e. don't bother, ignore.
(setq inhibit-x-resources t)

;; Cursor, tooltip and dialog box
(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))
(setq visible-cursor nil)
(setq use-dialog-box nil)
(setq x-gtk-use-system-tooltips nil)
(when (fboundp 'tooltip-mode)
  (tooltip-mode -1))

(setq display-line-numbers-type 'visual)
(dolist (hook '(prog-mode-hook text-mode-hook))
  (add-hook hook #'display-line-numbers-mode)
  (add-hook hook #'display-fill-column-indicator-mode))

(defvar aar/use-dark-theme nil
  "Use dark theme if `t' otherwise, use light theme")

  (mapc #'disable-theme custom-enabled-themes)
  (require-theme 'modus-themes)
  (setq modus-themes-org-blocks 'gray-background)
    (setq modus-themes-disable-other-themes t)
    ;; (setq doom-gruvbox-dark-variant "hard")

    (if aar/use-dark-theme
        (modus-themes-load-theme 'modus-vivendi-tinted)
      (modus-themes-load-theme 'modus-operandi-tinted))

(use-package hl-todo
  :init
  (dolist (hook '(prog-mode-hook tex-mode-hook markdown-mode-hook))
    (add-hook hook #'hl-todo-mode))

  ;; Stolen from doom-emacs: modules/ui/hl-todo/config.el
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(;; For reminders to change or add something at a later date.
          ("TODO" warning bold)
          ;; For code (or code paths) that are broken, unimplemented, or slow,
          ;; and may become bigger problems later.
          ("FIXME" error bold)
          ;; For code that needs to be revisited later, either to upstream it,
          ;; improve it, or address non-critical issues.
          ("REVIEW" font-lock-keyword-face bold)
          ;; For code smells where questionable practices are used
          ;; intentionally, and/or is likely to break in a future update.
          ("HACK" font-lock-constant-face bold)
          ;; For sections of code that just gotta go, and will be gone soon.
          ;; Specifically, this means the code is deprecated, not necessarily
          ;; the feature it enables.
          ("DEPRECATED" font-lock-doc-face bold)
          ;; Extra keywords commonly found in the wild, whose meaning may vary
          ;; from project to project.
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(use-package which-key
  :demand t
  :init
  (setq which-key-idle-delay 0.3)
  (setq which-key-allow-evil-operators t)
  (which-key-setup-minibuffer)
  (which-key-mode))

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-visual-char-semi-exclusive t)
  (setq evil-ex-search-vim-style-regexp t)
  (setq evil-ex-visual-char-range t)
  (setq evil-respect-visual-line-mode t)
  (setq evil-mode-line-format 'nil)
  (setq evil-symbol-word-search t)
  (setq evil-ex-interactive-search-highlight 'selected-window)
  (setq evil-kbd-macro-suppress-motion-error t)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (setq evil-flash-timer nil)
  (setq evil-complete-all-buffers nil)
  (evil-mode 1)
  (evil-set-initial-state 'messages-buffer-mode 'normal))

(provide 'init)
;;; init.el ends here
