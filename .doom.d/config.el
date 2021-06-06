;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, emailclients, file templates and snippets.
(setq user-full-name "Carson Freedman"
      user-mail-address "20868514+carsin@users.noreply.github.com")

;; Maximize Emacs on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

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
(setq company-idle-delay 0.5)                       ; delay for autocomplete
(setq load-prefer-newer t)          ; Load newest version of file that exists
(setq evil-vsplit-window-right t) ; New vertical splits always open on the right
(setq evil-split-window-below t) ; New horizontal splits always open below
(setq +ivy-buffer-preview t) ; Buffer previews in ivy
(setq scroll-margin 10) ; How many lines from cursor to top / bottom of the screen before scrolling
(setq doom-font (font-spec :family "Monaco" :size 16))
(setq doom-variable-pitch-font (font-spec :family "Monaco" :size 16))
(setq doom-serif-font (font-spec :family "New York" :size 12))
(setq doom-big-font (font-spec :family "Menlo" :size 20))
(setq doom-theme 'doom-gruvbox)

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
(hl-line-mode 0) ; Don't highlight the entire current line the cursor is on
(global-hl-line-mode 0) ; Don't highlight the entire current line the cursor is on
(beacon-mode 1) ; Highlight the cursor after disorienting cursor movements
(blink-cursor-mode 1) ; Blink the cursor while idle
(display-fill-column-indicator-mode 1) ; Blink the cursor while idle


;; Configure org settings
(after! org
        (setq org-directory "~/Files/Org/")
        (setq org-ellipsis  " ... ")
        (setq org-roam-directory "~/Files/Org/notes")
        (setq org-roam-tag-sources '(prop last-directory))
        (setq org-roam-db-location "~/Files/Org/db/roam.db")
    )

(after! rust
        (setq rustic-lsp-server 'rust-analyzer)
    )

(after! lsp
        (setq lsp-ui-sideline-enable t)
        (setq lsp-ui-sideline-show-diagnostics t)
        (setq lsp-ui-sideline-show-hover t)
        (setq lsp-ui-sideline-show-code-actions t)
        (setq lsp-ui-sideline-delay 0)
        (setq company-minimum-prefix-length 1) ; how many characters to start completing after
    )

(after! company
        (add-to-list 'company-backends 'company-tabnine)
        (add-to-list 'company-backends 'company-files)
    )
