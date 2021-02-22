;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
;; User Information
(setq user-full-name "Carson Freedman"
      user-mail-address "carsin@users.noreply.github.com")

(setq comp-speed 2)
(setq-default delete-by-moving-to-trash t                 ; Delete files to trash
              indent-tabs-mode nil                        ; Don't use tabs
              tab-width 4                                 ; Set width for tabs
              uniquify-buffer-name-style 'forward         ; Uniquify buffer names
              window-combination-resize t                 ; take new window space from all other windows (not just current)
              x-stretch-cursor t)                         ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      ;; evil-cross-lines t                          ; Makes horizontal movement not stop at EOL
      ;; default-directory: "~"                      ; Home :)
      company-idle-delay 0.1                       ; delay for autocomplete
      lsp-ui-sideline-enable nil
      load-prefer-newer t
      lsp-enable-symbol-highlighting nil
      company-dabbrev-downcase 0
      auto-save-default t)                        ; Nobody likes to lose work, I certainly don't

(delete-selection-mode 1)                         ; Replace selection when inserting text
(global-subword-mode 1)                           ; Iterate through CamelCase words
(auto-save-visited-mode +1)                       ; Enable autosaving on all buffers opened

;; Maximize Emacs window on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Font settings
(setq doom-font (font-spec :family "Menlo" :size 14)
      doom-variable-pitch-font (font-spec :family "Monaco" :size 10)
      doom-serif-font (font-spec :family "New York" :size 12)
      doom-big-font (font-spec :family "Menlo" :size 20))

;; Set theme
(setq doom-theme 'darktooth)

;; Configure org settings
(after! org
        (setq org-directory "~/org/"
              org-ellipsis " ... "
              org-roam-tag-sources '(prop last-directory)
              org-roam-directory "~/org/notes/"
              ;; deft-directory "~/org/notes/"
              org-roam-db-location "~/.emacs.d/roam.db"
              org-journal-file-type 'daily
              org-journal-date-prefix "#+title: Journal: "
              org-journal-file-format "%Y-%m-%d.org"
              org-journal-dir "~/org/notes/"
              org-journal-time-format "%I:%M %p"
              org-journal-date-format "%A, %d %B %Y"
              org-log-done 'time
              ;; org-agenda-skip-scheduled-if-done t
              ;; org-agenda-skip-deadline-if-done t
              ;; org-agenda-include-deadlines t
              ;; org-agenda-block-separator nil
              ;; org-agenda-tags-column 100
              ;; org-agenda-compact-blocks t
              org-hide-emphasis-markers t
              ;; org-pretty-entities t
              ;; org-use-sub-superscripts t
              ;; org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "INPROGRESS(i)" "|" "DONE(d)" "CANCELLED(c)"))
              ))

(add-to-list 'safe-local-variable-values
             '(org-roam-directory . "."))

;; Show absolute line numbering
(setq display-line-numbers-type t)

;; Split to bottom and right always
(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; Buffer previews in ivy
(setq +ivy-buffer-preview t)

;; How many lines from cursor to top / bottom of the screen before scrolling
(setq scroll-margin 10)

(defun doom-modeline-conditional-buffer-encoding ()
  ;; We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

;; Navigate by visual line
;; (define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
;; (define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)

(setq rustic-lsp-server 'rust-analyzer)

; enable everything on sideline
(setq lsp-ui-sideline-enable t)
(setq lsp-ui-sideline-show-diagnostics t)
(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-sideline-show-code-actions t)
(setq lsp-ui-sideline-delay 0)
(setq company-minimum-prefix-length 1) ; how many characters to start completing after

(add-to-list 'company-backends 'company-tabnine)
(add-to-list 'company-backends 'company-files)
;; (add-hook 'rustic-mode-hook
;;           (lambda ()
;;              (setq-local company-backends '((company-tabnine company-capf company-files company-yasnippet)))))

;; (defun tabnine-rust-hook ()
;;     (set (make-local-variable))

(setq global-hl-line-mode nil)
