;; User Information
(setq user-full-name "Carson Freedman"
      user-mail-address "carsin@users.noreply.github.com")

;; Some nice display defaults
(display-time-mode 1)
(setq display-time-day-and-date t)

(setq-default
      delete-by-moving-to-trash t                 ; Delete files to trash
      tab-width 4                                 ; Set width for tabs
      uniquify-buffer-name-style 'forward         ; Uniquify buffer names
      window-combination-resize t                 ; take new window space from all other windows (not just current)
      x-stretch-cursor t)                         ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t)                         ; Nobody likes to loose work, I certainly don't

(delete-selection-mode 1)                         ; Replace selection when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(unless (equal "Battery status not available"
        (battery))
        (display-battery-mode 1))                 ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
  (toggle-frame-fullscreen))

;; Font settings
(setq doom-font (font-spec :family "SF Mono" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Monaco" :size 12))

;; Set theme
(setq doom-theme 'doom-tomorrow-night)

;; Set org directory
(setq org-directory "~/org/")

;; Show absolute line numbering
(setq display-line-numbers-type t)
