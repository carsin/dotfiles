;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Carson"
      user-mail-address "20868514+carsin@users.noreply.github.com")

(setq org-directory "~/files/dev/calpoly/notes/")

;;
;; Variables
;;

;; Editor
(setq-default history-length 1000) ; Remembering history from precedent
(setq-default prescient-history-length 1000)
(setq-default xstretch-cursor t)            ; Stretch cursor to glyph width
(setq-default tab-width 4)
(setq-default hl-line-mode nil) ; Don't highlight the entire current line the cursor is on

(setq display-line-numbers-type t)  ; Enable line numbers
(setq undo-limit 80000000)                         ; Raise undo-limit to 80Mb
(setq evil-want-fine-undo t)                       ; By default while in insert all changes are one big blob. Be more granular
(setq company-idle-delay 0.3)                       ; delay for autocomplete
(setq load-prefer-newer t)          ; Load newest version of file that exists
(setq evil-vsplit-window-right t) ; New vertical splits always open on the right
(setq evil-split-window-below t) ; New horizontal splits always open below
(setq +ivy-buffer-preview t) ; Buffer previews in ivy
(setq scroll-margin 10) ; How many lines from cursor to top / bottom of the screen before scrolling
(setq org-hide-emphasis-markers t) ; hide markup elements from org docs
(setq doom-theme 'doom-gruvbox)
(doom/set-frame-opacity 92)

;;
;; Hooks
;;


;; We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

;;
;; Modes
;;

(delete-selection-mode 1)                         ; Replace selection when inserting text
(global-subword-mode 1)                           ; Iterate through CamelCase words
(auto-save-visited-mode +1)                       ; Enable autosaving on all buffers opened
(blink-cursor-mode 1) ; Blink the cursor while idle
(display-fill-column-indicator-mode 1) ; Blink the cursor while idle
