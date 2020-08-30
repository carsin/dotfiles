;; User Information
(setq user-full-name "Carson Freedman"
      user-mail-address "carsin@users.noreply.github.com")

;; Some nice display defaults
(display-time-mode 1)
(setq display-time-day-and-date t)
(setq org-clock-continuously t)

;; Font settings
(setq doom-font (font-spec :family "SF Mono" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Monaco" :size 12))

;; Set theme
(setq doom-theme 'doom-gruvbox)

;; Set org directory
(setq org-directory "~/org/")

;; Show absolute line numbering
(setq display-line-numbers-type t)
