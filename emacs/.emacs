(setq tls-checktrust t)
(setq gnutls-verify-error t)
(setq make-backup-files t)
(setq version-control t
      kept-new-versions 1000
      kept-old-version 2
      delete-old-versions nil
      backup-by-copying-when-linked t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
(setq org-agenda-files '("~/Documents/todo.org"))
(setq dired-dwim-target t)
(setq org-clock-sound "~/Downloads/bell.wav")
(setq default-todos "~/Documents/")
;;(setq show-paren-style 'expression)
(setq ring-bell-function 'ignore)
(global-visual-line-mode 1)
(column-number-mode 1)
(menu-bar-mode 0)
(show-paren-mode 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq message-log-max t)
(setq confirm-kill-emacs 'y-or-n-p)
;;(load-theme 'kaolin-valley-dark t)
(add-to-list 'default-frame-alist '(font . "monoid-18"))
(set-frame-font "monoid-18")
;(set-frame-font "Iosevka Nerd Font-22")
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(pixel-scroll-mode)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; (set-language-environment "UTF-8")  UTF8 as default
;; (set-default-coding-systems 'utf-8)
;; (delete-selection-mode 1) ; typing overwrite selected text
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(fset 'yes-or-no-p 'y-or-n-p)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(setq x-underline-at-descent-line t)
;;(setq solarized-distinct-fringe-background t)
(setq solarized-high-contrast-mode-line nil)

(add-hook 'emacs-startup-hook '(lambda () (find-file (concat default-todos "todo.org"))))
(add-hook 'prog-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'before-save-hook 'rc/set-up-whitespace-handling)

(global-set-key (kbd "C-x C-s") 'my-save-buffer)

(global-set-key (kbd "C-c w") 'my-delete-whitespace-rectangle)

(global-set-key (kbd "C-c c") 'comment-dwim)
(global-set-key (kbd "C-x a r") 'align-regexp)

(global-set-key (kbd "<f2>") 'recompile)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))



(defun my-delete-whitespace-rectangle ()
  "Delete repeated whitespaces and inserts one"
  (interactive)
  (while (or (looking-at " ")
                (looking-back " "))
       (if (looking-at " ")
           (delete-char 1))
       (if (looking-back " ")
           (delete-backward-char 1)))
  (insert " "))

(defun my-save-buffer ()
  (interactive)
  (let ((current-prefix-arg 4))
    (call-interactively 'save-buffer)))

(defun eshell-here ()
  (interactive)
  (let* ((height (/ (window-total-height) 3)))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(defun copy-selected-text (start end)
  (interactive "r")
  (if (use-region-p)
      (let ((text (buffer-substring-no-properties start end)))
        (shell-command (concat "echo " text " | clip.exe")))))

(use-package ess :ensure t)
(use-package olivetti :ensure t)
(use-package avy :ensure t
  :bind
  ("C-c j" . avy-goto-char-2))
(use-package lsp-ui :ensure t)
(use-package flycheck :ensure t)
(use-package lsp-mode :ensure t
  :hook ((c-mode . lsp)
         (c++-mode . lsp))
  :commands lsp)
(use-package lsp-java :ensure t
  :hook
  ((java-mode . lsp)
   (java-mode . lsp-lens-mode)))
(use-package rust-mode :ensure t)
(use-package pdf-tools :ensure t
  :config
  (pdf-tools-install))
(use-package docker
  :ensure t
  :bind ("C-c d" . docker))
(use-package git-timemachine :ensure t :defer t)
;; (use-package gruvbox-theme :ensure t :defer t
;;   :config
;;   (load-theme 'gruvbox-dark-medium t))
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark-high-contrast t))
(use-package python :ensure t :defer t
  :hook
  (python-mode . (lambda () (progn (setq python-indent-offset 4)
                                   (setq tab-width 4)))))
(use-package tramp :ensure t :defer t
  :config
  (setq tramp-default-method "ssh")
  (setq tramp-auto-save-directory "/tmp"))
(use-package org :ensure t :defer t
  :config
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((python . t)
        (R . t)
        (C . t)))
  (setq org-src-fontify-natively 't)
   (setq org-capture-templates
           '(
             ("b" "Bookmark" entry (file+headline "~/Documents/notes.org.gpg" "Bookmarks")
              "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1))))
(use-package org-bullets :ensure t :defer t
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))
(use-package hindent :ensure t :defer t
  :hook
  ((haskell-mode . hindent-mode)))
(use-package haskell-mode :ensure t :defer t
  :hook
  ((haskell-mode . interactive-haskell-mode)
   (haskell-mode . haskell-indent-mode)
   (haskell-mode . haskell-doc-mode)))
(use-package paredit :ensure t
  :hook ((lisp-mode . paredit-mode)
         (eval-expression-minibuffer-setup . paredit-mode)
         (emacs-lisp-mode . paredit-mode)
         (clojure-mode . paredit-mode)))
(use-package yasnippet :ensure t
  :diminish
  :config (yas-global-mode 1))
(use-package yasnippet-snippets :ensure t)
(use-package emmet-mode :ensure t :defer t
  :hook
  ((sgml-mode . emmet-mode)
   (css-mode . emmet-mode)
   (emmet-mode . (lambda () (local-set-key (kbd "M-TAB") 'emmet-expand-yas)))))
;; (use-package elpy
;;   :ensure t
;;   :defer t
;;   :init
;;   (elpy-enable))
(use-package ido-completing-read+ :ensure t :defer t :config
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-use-virtual-buffers t))
(use-package smex :ensure t :defer t :bind
  ("M-x" . smex))
(use-package company :ensure t
  :diminish company-mode
  :bind ("C-M-i" . company-complete)
  :config
  (global-company-mode)
  (setq company-backends
        '((company-files
           company-keywords)
          (company-abbrev company-dabbrev)))
  (setq company-idle-delay 0.0)
  (setq company-ctags-extra-tags-files '("$HOME/TAGS" "/usr/include/TAGS")))
(use-package company-posframe :ensure t
  :diminish company-posframe
  :after company
  :config (company-posframe-mode 1))
(use-package move-text :ensure t
             :bind
             (("M-p" . move-text-up)
              ("M-n" . move-text-down)))
(use-package expand-region :defer t :ensure t
             :bind ("C-=" . er/expand-region)
             :bind ("C--" . er/contract-region))
(use-package magit :ensure t :defer t
  :bind (("C-x g" . magit-status)))
(use-package rainbow-delimiters :ensure t :defer t
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package wrap-region :ensure t
  :diminish
  :config (wrap-region-global-mode))
(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->"         . mc/mark-next-like-this)
   ("C-<"         . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-:" . mc/skip-to-previous-like-this)
   ("C-\"" . mc/skip-to-next-like-this)))


(defun rc/delete-file ()
  (interactive)
  (when (file-exists-p buffer-file-name)
    (if (y-or-n-p (concat "Delete " buffer-file-name "?"))
        (progn
          (delete-file buffer-file-name)
          (message "Deleted file %s" buffer-file-name)))))

(defun rc/eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (let ((value (eval (elisp--preceding-sexp))))
    (backward-kill-sexp)
    (insert (format "%S" value))))

(global-set-key (kbd "C-c C-e") 'rc/eval-and-replace)
(global-set-key (kbd "C-c z") 'zap-up-to-char)
(global-set-key (kbd "C-z") 'repeat)

;; calendar
;; (setq calendar-latitude 59.938)
;; (setq calendar-longitude 30.31)

(defun insert-todays-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d-%m-%Y")
            (format-time-string "%A %H:%M %b %e"))))

(setq calendar-week-start-day 1)
(setq calendar-latitude 60.001168)
(setq calendar-longitude 30.42313)

(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

;; (setq auto-save-default nil)
;; (setq make-backup-files nil)

(put 'iconify-or-deiconify-frame 'disabled t)
(put 'suspend-emacs 'disabled t)
(put 'suspend-tty 'disabled t)


(unless (eq system-type 'windows-nt)
  (require 'server)
  (unless (server-running-p)
    (server-start)))

(defun rc/duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank))

(defun sudo ()
  "Use TRAMP to `sudo' the current buffer"
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
             buffer-file-name))))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

(defun rc/match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(defun rc/rename-file (new-name)
  (interactive "FNew name: ")
  (let ((filename (buffer-file-name)))
    (if filename
        (progn
          (when (buffer-modified-p)
            (save-buffer))
          (rename-file filename new-name t)
          (kill-buffer (current-buffer))
          (find-file new-name)
          (message "Renamed '%s' -> '%s'" filename new-name))
      (message "Buffer '%s' isn't backed by a file!" (buffer-name)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#11948b")
 '(cua-normal-cursor-color "#596e76")
 '(cua-overwrite-cursor-color "#a67c00")
 '(cua-read-only-cursor-color "#778c00")
 '(custom-enabled-themes (quote (kaolin-valley-dark)))
 '(custom-safe-themes
   (quote
    ("249e100de137f516d56bcf2e98c1e3f9e1e8a6dce50726c974fa6838fbfcec6b" "d9a28a009cda74d1d53b1fbd050f31af7a1a105aa2d53738e9aa2515908cac4c" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" default)))
 '(docker-command "docker.exe")
 '(fci-rule-color "#f4eedb")
 '(global-whitespace-newline-mode nil)
 '(highlight-changes-colors (quote ("#c42475" "#5e65b6")))
 '(highlight-symbol-colors
   (quote
    ("#ec91da4ab1ea" "#ccb4e1bed0ac" "#fb9eca14b390" "#d89bd3eadcf9" "#de2adee7b294" "#f676cca1ae7a" "#d060dab7e07a")))
 '(highlight-symbol-foreground-color "#5d737a")
 '(highlight-tail-colors
   (quote
    (("#f4eedb" . 0)
     ("#a8b84b" . 20)
     ("#66c1b3" . 30)
     ("#6fa5e7" . 50)
     ("#d6a549" . 60)
     ("#ed6e3e" . 70)
     ("#f46495" . 85)
     ("#f4eedb" . 100))))
 '(hl-bg-colors
   (quote
    ("#d6a549" "#ed6e3e" "#ff6243" "#f46495" "#837bdf" "#6fa5e7" "#66c1b3" "#a8b84b")))
 '(hl-fg-colors
   (quote
    ("#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9" "#fffce9")))
 '(hl-paren-colors (quote ("#11948b" "#a67c00" "#007ec4" "#5e65b6" "#778c00")))
 '(lsp-ui-doc-border "#5d737a")
 '(nrepl-message-colors
   (quote
    ("#cc1f24" "#bb3e06" "#a67c00" "#4f6600" "#a8b84b" "#005797" "#11948b" "#c42475" "#5e65b6")))
 '(package-selected-packages
   (quote
    (kaolin-themes go-mode scala-mode auto-sudoedit tramp multiple-cursors wrap-region rainbow-delimiters magit expand-region move-text company-posframe company smex ido-completing-read+ emmet-mode yasnippet-snippets yasnippet paredit haskell-mode hindent org-bullets solarized-theme git-timemachine docker pdf-tools rust-mode lsp-java flycheck lsp-ui avy olivetti ess use-package)))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#778c00" "#f4eedb" 0.2))
 '(term-default-bg-color "#fffce9")
 '(term-default-fg-color "#596e76")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc1f24")
     (40 . "#bb0259ab189c")
     (60 . "#b11e6bfb0f59")
     (80 . "#a67c00")
     (100 . "#976f81f50000")
     (120 . "#8fd084af0000")
     (140 . "#87e987420000")
     (160 . "#7fab89b10000")
     (180 . "#778c00")
     (200 . "#690f8e6a3f47")
     (220 . "#5eff8fb4534b")
     (240 . "#516591106635")
     (260 . "#3d38927e78ad")
     (280 . "#11948b")
     (300 . "#1ae78b4ea1e7")
     (320 . "#194186e8ad47")
     (340 . "#127c8279b8a3")
     (360 . "#007ec4"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fffce9" "#f4eedb" "#990001" "#cc1f24" "#4f6600" "#778c00" "#785700" "#a67c00" "#005797" "#007ec4" "#93004d" "#c42475" "#006d68" "#11948b" "#596e76" "#88999b")))
 '(whitespace-style
   (quote
    (face trailing spaces lines newline empty indentation space-after-tab space-before-tab space-mark)))
 '(xterm-color-names
   ["#f4eedb" "#cc1f24" "#778c00" "#a67c00" "#007ec4" "#c42475" "#11948b" "#002b37"])
 '(xterm-color-names-bright
   ["#fffce9" "#bb3e06" "#98a6a6" "#88999b" "#596e76" "#5e65b6" "#5d737a" "#00212b"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-big-indent ((t (:foreground "firebrick"))))
 '(whitespace-tab ((((class color) (min-colors 89)) (:background nil :foreground "#cc1f24" :inverse-video t)))))
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'suspend-frame 'disabled nil)
