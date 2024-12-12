(setq tls-checktrust t)
(setq gnutls-verify-error t)
(setq make-backup-files t)
(setq whitespace-style '(face tabs spaces space-before-tab newline indentation empty space-after-tab space-mark tab-mark))
(setq version-control t
      kept-new-versions 1000
      kept-old-version 2
      delete-old-versions nil
      backup-by-copying-when-linked t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
(setq auto-save-default nil)
(setq org-agenda-files '("~/Documents/org-notes/todo.org"))
(setq default-todos "~/Documents/org-notes/")
(set-register ?z '(file . "/home/diamond/repos/irzos/zos-wrt"))
(filesets-init)
;; (add-hook 'emacs-startup-hook '(lambda () (find-file (concat default-todos "todo.org"))))
(setq initial-buffer-choice (concat default-todos "todo.org"))
(setq dired-dwim-target t)
(setq org-clock-sound "~/Downloads/bell.wav")
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
(set-frame-font "Iosevka Nerd Font Mono-14")
(add-to-list 'default-frame-alist '(font . "Iosevka-15"))

(setq message-sendmail-f-is-evil 't)
(setq sendmail-program "/usr/bin/msmtp")
(setq message-send-mail-function 'message-send-mail-with-sendmail)
(setq user-full-name "Dmitrii Elizarov")
(setq user-mail-address "delizarov@radiofid.ru")
(setq mail-specify-envelope-from t)

;; pasta
;; (setq mail-envelope-from 'header)
(setq message-sendmail-envelope-from 'header)
;; (setq message-send-mail-function 'message-send-mail-with-sendmail)
;; (setq sendmail-program "/usr/bin/msmtp")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;; (delete-selection-mode 1) ; typing overwrite selected text
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(fset 'yes-or-no-p 'y-or-n-p)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; (global-display-line-numbers-mode)
(setq x-underline-at-descent-line t)
;;(setq solarized-distinct-fringe-background t)
(setq solarized-high-contrast-mode-line nil)

(add-hook 'prog-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'before-save-hook 'rc/set-up-whitespace-handling)

(global-set-key (kbd "C-x C-s") 'my-save-buffer)
(global-set-key (kbd "C-c w") 'my-delete-whitespace-rectangle)
(global-set-key (kbd "C-c c") 'comment-dwim)
(global-set-key (kbd "C-x a r") 'align-regexp)
(global-set-key (kbd "<f2>") 'recompile)

(add-to-list 'auto-mode-alist '("\\.uc\\'" . js-mode))


(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(defun gen-tags ()
  "Generate TAGS in prompted directory"
  (interactive)
  (let ((default-directory (read-directory-name "Choose directory name: ")))
    (shell-command "find . -name \"*.c\" -print -or -name \"*.h\" -print | xargs etags --append")))

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

(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  ;;(add-to-list 'write-file-functions 'delete-trailing-whitespace)
  )

;;(add-hook 'c-mode 'lsp)
;;(add-hook 'c-mode 'c-submode)

;; (setq write-file-functions (whitespace-write-file-hook))
;; (use-package docker-compose-mode)

;; (use-package lsp-mode :ensure t
;;   :hook (
;;          (c-mode . lsp)))
(use-package jinx
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))
(use-package fountain-mode :ensure t)
(use-package academic-phrases :ensure t)
(use-package fb2-reader :ensure t)
(use-package julia-mode :ensure t)
(use-package circadian :ensure t)
(use-package rainbow-mode :ensure t)
(use-package dockerfile-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package ess :ensure t)
(use-package olivetti :ensure t)
(use-package avy :ensure t
  :bind
  ("C-c j" . avy-goto-char-2))
(use-package flycheck :ensure t)
(use-package rust-mode :ensure t)
(use-package pdf-tools :ensure t
  :config
  (pdf-tools-install))
(use-package docker
  :ensure t
  :bind ("C-c d" . docker))
(use-package git-timemachine :ensure t :defer t)
(use-package gruvbox-theme :ensure t :defer t
  :config
  (load-theme 'gruvbox-dark-medium t))
;; (use-package solarized-theme
;;   :ensure t
;;   :config
;;   (load-theme 'solarized-dark-high-contrast t))
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
        (C . t)
        (sh . t)
))
  (setq org-src-fontify-natively 't)
   (setq org-capture-templates
           '(
             ("b" "Bookmark" entry (file+headline "~/Documents/notes.org.gpg" "Bookmarks")
              "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1))))
(use-package org-roam :ensure t :defer t)
(use-package org-modern :ensure t :defer t
  :after org
  :hook
  (org-mode . (lambda () (org-modern-mode))))
(use-package hindent :ensure t :defer t
  :hook
  ((haskell-mode . hindent-mode)))
(use-package haskell-mode :ensure t :defer t
  :hook
  ((haskell-mode . interactive-haskell-mode)
   (haskell-mode . haskell-indent-mode)
   (haskell-mode . haskell-doc-mode)))
(use-package ada-mode :ensure t :defer t)
(use-package paredit :ensure t
  :hook ((lisp-mode . paredit-mode)
         ;; (eval-expression-minibuffer-setup . paredit-mode)
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
        '(company-files
          company-keywords
          company-ctags
          company-abbrev company-dabbrev))
  (setq company-idle-delay 0.0)
  (setq company-ctags-extra-tags-files '("$HOME/TAGS" "/usr/include/tags" "/usr/include/TAGS")))
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
   ("C-c C-<" . mc/mark-all-like-this)
   ("C-," . mc/skip-to-previous-like-this)
   ("C-." . mc/skip-to-next-like-this)
   ))

(use-package doom-themes         :ensure t)
(use-package gruber-darker-theme :ensure t)
(use-package kaolin-themes       :ensure t)
(use-package jazz-theme          :ensure t)
(use-package modus-themes        :ensure t)
;;(set-frame-font "Fantasque Sans Mono-17")

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
(global-set-key (kbd "C-x z") 'zap-up-to-char)
(global-set-key (kbd "C-z") 'repeat)

(global-unset-key (kbd "C-x C-z"))

(defun insert-todays-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d-%m-%Y")
            (format-time-string "%A %H:%M %b %e"))))

(setq calendar-week-start-day 1)
(setq calendar-latitude 60.001168)
(setq calendar-longitude 30.42313)

;; (setq server-socket-dir (format "/tmp/emacs%d" (user-uid)))

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
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#3cafa5")
 '(cua-normal-cursor-color "#8d9fa1")
 '(cua-overwrite-cursor-color "#c49619")
 '(cua-read-only-cursor-color "#93a61a")
 '(custom-enabled-themes '(gruvbox-dark-hard))
 '(custom-safe-themes
   '("524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307" "6e33d3dd48bc8ed38fd501e84067d3c74dfabbfc6d345a92e24f39473096da3f" "ffafb0e9f63935183713b204c11d22225008559fa62133a69848835f4f4a758c" "10e5d4cc0f67ed5cafac0f4252093d2119ee8b8cb449e7053273453c1a1eb7cc" "014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" "e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7" "703a3469ae4d2a83fd5648cac0058d57ca215d0fea7541fb852205e4fae94983" "c7a926ad0e1ca4272c90fce2e1ffa7760494083356f6bb6d72481b879afce1f2" "64045b3416d83e5eac0718e236b445b2b3af02ff5bcd228e9178088352344a92" "0f76f9e0af168197f4798aba5c5ef18e07c926f4e7676b95f2a13771355ce850" "cb8eb6d80c3908a53b0c8a98ab0cedd007c1f10593a5f0f1e2ee24eec241e3e0" "b29ba9bfdb34d71ecf3322951425a73d825fb2c002434282d2e0e8c44fce8185" "bbfccff82c1d35611cdf25339401a483875b32472fae7fcdaf14bd12c3a05b07" "d19b94d54f496bfca31bb9e3db039ce89fa363f1bdd42e160e8482ed9232c280" "a131602c676b904a5509fff82649a639061bf948a5205327e0f5d1559e04f5ed" "c95813797eb70f520f9245b349ff087600e2bd211a681c7a5602d039c91a6428" "16198c5c7319d07ded977d2414a96fff95f468af313cff6f684fd02f9dfff9b2" "b02eae4d22362a941751f690032ea30c7c78d8ca8a1212fdae9eecad28a3587f" "c8b83e7692e77f3e2e46c08177b673da6e41b307805cd1982da9e2ea2e90e6d7" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "ba323a013c25b355eb9a0550541573d535831c557674c8d59b9ac6aa720c21d3" "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd" "a5270d86fac30303c5910be7403467662d7601b821af2ff0c4eb181153ebfc0a" "4c7228157ba3a48c288ad8ef83c490b94cb29ef01236205e360c2c4db200bb18" "1930427eae3d4d830a43fd79fbda76021138b929c243a4e8606cf4f0531ea17c" "27eb4bbd908683d344af2a0b90d71698938ab9af1656b1aed87e68258ef8c980" "9312a0692efc799e797c6689b3216c45d80e460184f666fffdb6dab65d8d4947" "871b064b53235facde040f6bdfa28d03d9f4b966d8ce28fb1725313731a2bcc8" "046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "fd1801cbdc655cef67f526de3c785dd41ea4a68631dc4a1bff262d0d3c7cdb5a" "18d1131ad6ff8e8e34287d6de9299faba4f1b03874278463fb6f38e3abe65bdc" "ba111a1e27970b905958219697ba50a78381c4f51d05eaf6fa6c0bdd5700847b" "5a00018936fa1df1cd9d54bee02c8a64eafac941453ab48394e2ec2c498b834a" "249e100de137f516d56bcf2e98c1e3f9e1e8a6dce50726c974fa6838fbfcec6b" "06ed754b259cb54c30c658502f843937ff19f8b53597ac28577ec33bb084fa52" "e266d44fa3b75406394b979a3addc9b7f202348099cfde69e74ee6432f781336" "b95f61aa5f8a54d494a219fcde9049e23e3396459a224631e1719effcb981dbd" "2ce76d65a813fae8cfee5c207f46f2a256bac69dacbb096051a7a8651aa252b0" "0170347031e5dfa93813765bc4ef9269a5e357c0be01febfa3ae5e5fcb351f09" "9cd57dd6d61cdf4f6aef3102c4cc2cfc04f5884d4f40b2c90a866c9b6267f2b3" "74e2ed63173b47d6dc9a82a9a8a6a9048d89760df18bc7033c5f91ff4d083e37" "788121c96b7a9b99a6f35e53b7c154991f4880bb0046a80330bb904c1a85e275" "6128465c3d56c2630732d98a3d1c2438c76a2f296f3c795ebda534d62bb8a0e3" "b5fab52f16546a15f171e6bd450ff11f2a9e20e5ac7ec10fa38a14bb0c67b9ab" "3c7a784b90f7abebb213869a21e84da462c26a1fda7e5bd0ffebf6ba12dbd041" "3e3230b21afe4ed67e74b8d29c71cd5177d7e00173aa8dc4d1a194b295fb6e6b" "7fd9e3ef1d713ffbf413ee6abf9cb0e6f7106cba6dea7c3e89fe1b3449cf99bd" "d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" "0d09f49e81c811f4a661ff63b82d2b812ce034aed336903922b06362b8cb0bbe" "5f7bbe37beb2238ed447dab41f400471e26e9e6edd41c418a15a75675872e4e2" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "94adc319e207c4e9fc5fcec552387dbd4a999fa30081b2a98dfa6430ac4f75dd" "c7b8dbc62bf969295d0068d8dcb47bd1832d9c466bd76ddc6ac325b93cbdf7c6" "bd82c92996136fdacbb4ae672785506b8d1d1d511df90a502674a51808ecc89f" "ecc077ef834d36aa9839ec7997aad035f4586df7271dd492ec75a3b71f0559b3" "7a4784fc0c0c853c578132e81a757a0f9b3e675fdd7e56303f3ee1fb8d7ae2a3" "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" "2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "5d59bd44c5a875566348fa44ee01c98c1d72369dc531c1c5458b0864841f887c" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "267cf309b02f463cd50df6a9ca67034e32698510995fefaa3c1bfee2c0d30f0e" "b4e786d88aeb48bce6c3b93a72d50e9c98966b759b2b09d837ea93e25acb8cc2" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "91964f59704afb8941929ff19894e3ae5b614c2a29ccb72c8b2bbf0502c8054d" "a3e99dbdaa138996bb0c9c806bc3c3c6b4fd61d6973b946d750b555af8b7555b" "e8882a809fb14f2307410a659846a06bfa58a2279ffb1f5aca0c3aecbcb6aaee" "f028e1985041fd072fa9063221ee9c9368a570d26bd6660edbd00052d112e8bb" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659" "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "70cfdd2e7beaf492d84dfd5f1955ca358afb0a279df6bd03240c2ce74a578e9e" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" default))
 '(docker-command "docker")
 '(dockerfile-mode-command "docker")
 '(fci-rule-color "#01323d")
 '(highlight-changes-colors '("#e2468f" "#7a7ed2"))
 '(highlight-symbol-colors
   '("#3c6f408d329d" "#0c4a45f64ce3" "#486e33913532" "#1fac3bea568d" "#2ec943ac3324" "#449935a7314d" "#0b04411b5986"))
 '(highlight-symbol-foreground-color "#9eacac")
 '(highlight-tail-colors
   '(("#01323d" . 0)
     ("#687f00" . 20)
     ("#008981" . 30)
     ("#0069b0" . 50)
     ("#936d00" . 60)
     ("#a72e01" . 70)
     ("#a81761" . 85)
     ("#01323d" . 100)))
 '(hl-bg-colors
   '("#936d00" "#a72e01" "#ae1212" "#a81761" "#3548a2" "#0069b0" "#008981" "#687f00"))
 '(hl-fg-colors
   '("#002732" "#002732" "#002732" "#002732" "#002732" "#002732" "#002732" "#002732"))
 '(hl-paren-colors '("#3cafa5" "#c49619" "#3c98e0" "#7a7ed2" "#93a61a"))
 '(ispell-dictionary nil)
 '(linum-format " %5i ")
 '(lsp-ui-doc-border "#9eacac")
 '(nrepl-message-colors
   '("#ec423a" "#db5823" "#c49619" "#687f00" "#c3d255" "#0069b0" "#3cafa5" "#e2468f" "#7a7ed2"))
 '(org-agenda-files '("/home/diamond/Documents/org-notes/todo.org"))
 '(package-selected-packages
   '(jinx gruber-darker monokai-pro-theme nordless-theme modus-themes gruber-darker-theme doom-themes solo-jazz-theme tommyh-theme nix-mode jazz-theme uwu-theme auto-org-md academic-phrases adoc-mode nezburn-theme notmuch nftables-mode plantuml-mode tramp nov dream-theme kaolin-themes nord-theme fb2-reader zenburn-theme doom-modeline ada-mode eglot timu-rouge-theme tron-legacy-theme rustic org-modern sublimity cmake-mode ox-hugo ox-asciidoc counsel-tramp counsel-etags moe-theme naysayer-theme gruvbox-theme docker company-ctags helm dockerfile-mode rainbow-mode yaml-mode yasnippet-snippets wrap-region use-package solarized-theme smex rust-mode rainbow-delimiters pdf-tools paredit org-bullets olivetti multiple-cursors move-text ido-completing-read+ hindent haskell-mode git-timemachine flycheck expand-region ess emmet-mode company-posframe avy))
 '(whitespace-display-mappings
   '((space-mark 32
                 [183]
                 [46])
     (space-mark 160
                 [164]
                 [95])
     (tab-mark 9
               [187 9]
               [92 9])))
 '(xterm-color-names
   ["#01323d" "#ec423a" "#93a61a" "#c49619" "#3c98e0" "#e2468f" "#3cafa5" "#faf3e0"])
 '(xterm-color-names-bright
   ["#002732" "#db5823" "#62787f" "#60767e" "#8d9fa1" "#7a7ed2" "#9eacac" "#ffffee"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'suspend-frame 'disabled t)
(put 'iconify-or-deiconify-frame 'disabled t)
(put 'suspend-emacs 'disabled t)
(put 'suspend-tty 'disabled t)
