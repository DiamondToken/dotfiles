(setq tls-checktrust t)
(setq gnutls-verify-error t)

(setq ring-bell-function 'ignore)
(global-visual-line-mode 1)
(column-number-mode 1)
(menu-bar-mode 0)
(show-paren-mode 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq message-log-max t)
;;(load-theme 'kaolin-valley-dark t)
;;(load-theme 'solarized-dark-high-contrast t)
(set-frame-font "mononoki-20" nil t)
(add-to-list 'default-frame-alist '(font . "mononoki-20" ))
(set-face-attribute 'default nil :font "mononoki-20" :height 200)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; (set-language-environment "UTF-8")  UTF8 as default
;; (set-default-coding-systems 'utf-8)
;;(delete-selection-mode 1) ; typing overwrite selected text
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(fset 'yes-or-no-p 'y-or-n-p)
;;(global-hl-line-mode nil)
(setq display-line-numbers-type 'relative)
;;(setq global-display-line-numbers 'relative)
(global-display-line-numbers-mode)
(setq x-underline-at-descent-line t)
;;(setq solarized-distinct-fringe-background t)
;;(setq solarized-high-contrast-mode-line t)
;;(load-theme 'doom-old-hope t)

(add-hook 'prog-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'before-save-hook 'rc/set-up-whitespace-handling)

(global-set-key (kbd "C-c c") 'comment-dwim)
(global-set-key (kbd "C-x a r") 'align-regexp)

(setq c-default-style "java")

(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;;(global-set-key (kbd "C-s") 'helm-swoop)
;; (global-set-key (kbd "M-s") 'helm-find-files)
(global-set-key (kbd "<f2>") 'recompile)
;; (when (not (package-installed-p 'use-package))
;;   (package-refresh-contents)
;;   (package-install 'use-package))

(defun eshell-here ()
  (interactive)
  (let* ((height (/ (window-total-height) 3)))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(use-package git-timemachine :ensure t :defer t)
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
  (setq tramp-default-method "ssh"))
(use-package org :ensure t :defer t
  :config
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((python . t)
        (R . t)
        (C . t)))
   (setq org-capture-templates
           '(
             ("b" "Bookmark" entry (file+headline "~/Documents/org-mode/notes.org" "Bookmarks")
              "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1))))
(use-package hindent :ensure t :defer t
  :hook
  ((haskell-mode . hindent-mode)))
(use-package haskell-mode :ensure t :defer t
  :hook
  ((haskell-mode . interactive-haskell-mode)))
(use-package paredit :ensure t
  :hook ((lisp-mode . paredit-mode)
         (eval-expression-minibuffer-setup . paredit-mode)
         (emacs-lisp-mode . paredit-mode)
         (clojure-mode . paredit-mode)))
(use-package yasnippet :ensure t
  :diminish
  :config (yas-global-mode 1))
(use-package yasnippet-snippets :ensure t)
(use-package helm :ensure t :defer t)
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
  (setq ido-enable-flex-matching t))
(use-package smex :ensure t :defer t :bind
  ("M-x" . smex))
(use-package company :ensure t
  :bind ("M-TAB" . company-complete)
  :config
  (global-company-mode)
  (setq company-idle-delay 0.0))
(use-package company-posframe :ensure t
  :after company
  :config
  :hook (company-mode . company-posframe-mode))
(use-package move-text :ensure t
             :bind
             (("M-p" . move-text-up)
              ("M-n" . move-text-down)))
(use-package expand-region :defer t :ensure t
             :bind ("C-=" . er/expand-region))
(use-package magit :ensure t :defer t
  :bind (("C-x g" . magit-status)))
(use-package rainbow-delimiters :ensure t :defer t
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package wrap-region :ensure t
  :diminish
  :config (wrap-region-global-mode))
(use-package multiple-cursors
  :defer t
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->"         . mc/mark-next-like-this)
   ("C-<"         . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-\"" . mc/skip-to-next-like-this)
   ("C-:" . mc/skip-to-next-like-this)))

(add-hook 'org-mode-hook 'org-bullets-mode)

(defun rc/eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (let ((value (eval (elisp--preceding-sexp))))
    (backward-kill-sexp)
    (insert (format "%S" value))))

(global-set-key (kbd "C-c C-e") 'rc/eval-and-replace)

(global-set-key (kbd "C-z") 'repeat)

;; calendar
(setq calendar-week-start-day 1)
(setq calendar-latitude 59.938)
(setq calendar-longitude 30.31)

(defun rc/set-up-whitespace-handling ()
  (interactive)
;;  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(setq auto-save-default nil)
(setq make-backup-files nil)

(put 'iconify-or-deiconify-frame 'disabled t)
(put 'suspend-emacs 'disabled t)
(put 'suspend-tty 'disabled t)

(server-start)

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

(defun match-paren (arg)
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
 '(package-selected-packages
   '(diminish zenburn-theme yasnippet-snippets yapfify wrap-region w3m use-package tramp tommyh-theme sublime-themes subatomic-theme soothe-theme solarized-theme smex seti-theme rainbow-mode rainbow-delimiters pythonic python-docstring python pydoc projectile phoenix-dark-pink-theme pdf-tools paredit panda-theme organic-green-theme org-bullets org nord-theme noctilux-theme nix-mode multiple-cursors multi move-text monokai-theme monokai-pro-theme monokai-alt-theme molokai-theme moe-theme modus-vivendi-theme modus-operandi-theme magit kosmos-theme kaolin-themes jedi jazz-theme ido-completing-read+ hindent helm-xref helm-tramp helm-swoop helm-gtags helm-git-grep helm-git helm-cscope helm-codesearch haskell-tab-indent haskell-snippets gruvbox-theme gruber-darker-theme git-timemachine gif-screencast gh-md ggtags frame-local flatland-theme flatland-black-theme firecode-theme evil-numbers eshell-syntax-highlighting emmet-mode embrace elpy elfeed doom-themes djvu direx-grep dash-functional dante company-ycmd company-posframe company-jedi company-ghci company-ctags company-c-headers company-auctex clang-capf cl-libify bash-completion avy auctex-latexmk ample-zen-theme ample-theme all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-ibuffer all-the-icons-gnus all-the-icons-dired alect-themes agda2-mode afternoon-theme))
 '(whitespace-style
   '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-big-indent ((t nil)))
 '(whitespace-indentation ((t nil))))
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'suspend-frame 'disabled nil)
