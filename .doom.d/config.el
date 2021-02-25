;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, emailclients, file templates and snippets.
(setq user-full-name "Carson Freedman"
      user-mail-address "20868514+carsin@users.noreply.github.com")

;; Maximize Emacs on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Editor
(setq display-line-numbers-type t)  ; Enable line numbers
(setq xstretch-cursor t)            ; Stretch cursor to glyph width
(setq tab-width 4)
(setq undo-limit 80000000)                         ; Raise undo-limit to 80Mb
(setq evil-want-fine-undo t)                       ; By default while in insert all changes are one big blob. Be more granular
(setq company-idle-delay 0.1)                       ; delay for autocomplete
(setq load-prefer-newer t)          ; Load newest version of file that exists

;; Modes
(delete-selection-mode 1)                         ; Replace selection when inserting text
(global-subword-mode 1)                           ; Iterate through CamelCase words
(auto-save-visited-mode +1)                       ; Enable autosaving on all buffers opened

(setq doom-theme 'darktooth)

;; Configure org settings
;; (after! org
;;         (setq org-directory "~/Files/Org/")
;;         (setq org-ellipsis  " ... ")
;;     )
