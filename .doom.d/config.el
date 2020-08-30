;; User Information
(setq user-full-name "Carson Freedman"
      user-mail-address "carsin@users.noreply.github.com")

;; Some nice display defaults
;; (display-time-mode 1)
;; (setq display-time-day-and-date t)

(setq-default
      delete-by-moving-to-trash t                 ; Delete files to trash
      indent-tabs-mode nil                        ; Don't use tabs
      tab-width 4                                 ; Set width for tabs
      uniquify-buffer-name-style 'forward         ; Uniquify buffer names
      window-combination-resize t                 ; take new window space from all other windows (not just current)
      x-stretch-cursor t)                         ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t)                        ; Nobody likes to lose work, I certainly don't

(delete-selection-mode 1)                         ; Replace selection when inserting text
;; (unless (equal "Battery status not available"
;;         (battery))
;;         (display-battery-mode 1))                 ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
  (toggle-frame-fullscreen))

;; Font settings
(setq doom-font (font-spec :family "SF Mono" :size 12 :weight 'semi-light)
      doom-big-font (font-spec :family "SF Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "SF Mono" :size 12))

;; Set theme
(setq doom-theme 'doom-tomorrow-night)

;; Set org directory
(setq org-directory "~/org/")

;; Show absolute line numbering
(setq display-line-numbers-type t)

;; Split to bottom and right always
(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; Open ivy to select buffer on new split
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

;; Buffer previews in ivy
(setq +ivy-buffer-preview t)

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)
