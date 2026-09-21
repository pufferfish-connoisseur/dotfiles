;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Ioskeley Mono" :size 12.0))

(setq doom-theme 'ef-dream)
(add-hook! 'doom-load-theme-hook
  (modus-themes-with-colors
    (custom-theme-set-faces! doom-theme
      `(diff-hl-insert :background ,fg-added-intense   :foreground ,fg-added-intense)
      `(diff-hl-delete :background ,fg-removed-intense :foreground ,fg-removed-intense)
      `(diff-hl-change :background ,fg-changed-intense :foreground ,fg-changed-intense))))

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(setq shell-file-name (executable-find "bash"))

;; Rounded corner macos
(if (eq system-type 'darwin)
    (add-to-list 'default-frame-alist '(undecorated-round . t)))

(use-package! chezmoi)
