(setq tls-checktrust t)
(setq gnutls-verify-error t)
(setq make-backup-files t)
(setq version-control t
      kept-new-versions 30
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
(add-to-list 'default-frame-alist '(font . "Iosevka-24"))
(set-frame-font "Iosevka-24")
;(set-frame-font "Iosevka Nerd Font-22")
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

(setq doom-modeline-height 40)
(doom-modeline-mode 1)
;; (use-package ccls
;;   :ensure t
;;   :config
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp)))
;;   (setq ccls-executable "/usr/local/bin/ccls")
;;   (setq ccls-initialization-options
;; '(:index (:comments 2) :completion (:detailedLabel t)))
;;   )

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
   ("C-\"" . mc/skip-to-next-like-this)
   ("C-:" . mc/skip-to-next-like-this)))

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

(require 'server)
(unless (server-running-p)
   (server-start))

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
 '(ansi-color-faces-vector
   [default bold shadow italic underline success warning error])
 '(ansi-color-names-vector
   ["#32302f" "#fb4933" "#98971a" "#d79921" "#458588" "#d3869b" "#689d6a" "#282828"])
 '(awesome-tray-mode-line-active-color "#2fafff")
 '(awesome-tray-mode-line-inactive-color "#323232")
 '(beacon-color "#ed0547ad8099")
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#689d6a")
 '(cua-normal-cursor-color "#a89984")
 '(cua-overwrite-cursor-color "#d79921")
 '(cua-read-only-cursor-color "#98971a")
 '(custom-enabled-themes '(doom-gruvbox))
 '(custom-safe-themes
   '("c7000071e9302bee62fbe0072d53063da398887115ac27470d664f9859cdd41d" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "5a00018936fa1df1cd9d54bee02c8a64eafac941453ab48394e2ec2c498b834a" "249e100de137f516d56bcf2e98c1e3f9e1e8a6dce50726c974fa6838fbfcec6b" "06ed754b259cb54c30c658502f843937ff19f8b53597ac28577ec33bb084fa52" "e8567ee21a39c68dbf20e40d29a0f6c1c05681935a41e206f142ab83126153ca" "47db50ff66e35d3a440485357fb6acb767c100e135ccdf459060407f8baea7b2" "da53441eb1a2a6c50217ee685a850c259e9974a8fa60e899d393040b4b8cc922" "f7fed1aadf1967523c120c4c82ea48442a51ac65074ba544a5aefc5af490893b" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "333958c446e920f5c350c4b4016908c130c3b46d590af91e1e7e2a0611f1e8c5" "8146edab0de2007a99a2361041015331af706e7907de9d6a330a3493a541e5a6" "a6e620c9decbea9cac46ea47541b31b3e20804a4646ca6da4cce105ee03e8d0e" "0d01e1e300fcafa34ba35d5cf0a21b3b23bc4053d388e352ae6a901994597ab1" "fe2539ccf78f28c519541e37dc77115c6c7c2efcec18b970b16e4a4d2cd9891d" "353ffc8e6b53a91ac87b7e86bebc6796877a0b76ddfc15793e4d7880976132ae" "a0be7a38e2de974d1598cf247f607d5c1841dbcef1ccd97cded8bea95a7c7639" "9b54ba84f245a59af31f90bc78ed1240fca2f5a93f667ed54bbf6c6d71f664ac" "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b" "1d44ec8ec6ec6e6be32f2f73edf398620bb721afeed50f75df6b12ccff0fbb15" "c5ded9320a346146bbc2ead692f0c63be512747963257f18cc8518c5254b7bf5" "e2c926ced58e48afc87f4415af9b7f7b58e62ec792659fcb626e8cba674d2065" "846b3dc12d774794861d81d7d2dcdb9645f82423565bfb4dad01204fa322dbd5" "d6844d1e698d76ef048a53cefe713dbbe3af43a1362de81cdd3aefa3711eae0d" "5f19cb23200e0ac301d42b880641128833067d341d22344806cdad48e6ec62f6" "c2aeb1bd4aa80f1e4f95746bda040aafb78b1808de07d340007ba898efa484f5" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "745d03d647c4b118f671c49214420639cb3af7152e81f132478ed1c649d4597d" "4699e3a86b1863bbc695236036158d175a81f0f3ea504e2b7c71f8f7025e19e3" "1278c5f263cdb064b5c86ab7aa0a76552082cf0189acf6df17269219ba496053" "1bddd01e6851f5c4336f7d16c56934513d41cc3d0233863760d1798e74809b4b" "6f4421bf31387397f6710b6f6381c448d1a71944d9e9da4e0057b3fe5d6f2fad" "4a5aa2ccb3fa837f322276c060ea8a3d10181fecbd1b74cb97df8e191b214313" "e19ac4ef0f028f503b1ccafa7c337021834ce0d1a2bca03fcebc1ef635776bea" "0466adb5554ea3055d0353d363832446cd8be7b799c39839f387abb631ea0995" "4b6b6b0a44a40f3586f0f641c25340718c7c626cbf163a78b5a399fbe0226659" "84b14a0a41bb2728568d40c545280dbe7d6891221e7fbe7c2b1c54a3f5959289" "e8df30cd7fb42e56a4efc585540a2e63b0c6eeb9f4dc053373e05d774332fc13" "76ed126dd3c3b653601ec8447f28d8e71a59be07d010cd96c55794c3008df4d7" "b5803dfb0e4b6b71f309606587dd88651efe0972a5be16ece6a958b197caeed8" "d47f868fd34613bd1fc11721fe055f26fd163426a299d45ce69bef1f109e1e71" "6c531d6c3dbc344045af7829a3a20a09929e6c41d7a7278963f7d3215139f6a7" "b186688fbec5e00ee8683b9f2588523abdf2db40562839b2c5458fcfb322c8a4" "23c806e34594a583ea5bbf5adf9a964afe4f28b4467d28777bcba0d35aa0872e" "266ecb1511fa3513ed7992e6cd461756a895dcc5fef2d378f165fed1c894a78c" "8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "3d47380bf5aa650e7b8e049e7ae54cdada54d0637e7bac39e4cc6afb44e8463b" "97db542a8a1731ef44b60bc97406c1eb7ed4528b0d7296997cbb53969df852d6" "cbdf8c2e1b2b5c15b34ddb5063f1b21514c7169ff20e081d39cf57ffee89bc1e" "6c98bc9f39e8f8fd6da5b9c74a624cbb3782b4be8abae8fd84cbc43053d7c175" "028c226411a386abc7f7a0fba1a2ebfae5fe69e2a816f54898df41a6a3412bb5" "9e3ea605c15dc6eb88c5ff33a82aed6a4d4e2b1126b251197ba55d6b86c610a1" "ba9c91bc43996f2fa710e4b5145d9de231150103e142acdcf24adcaaf0db7a17" "22f080367d0b7da6012d01a8cd672289b1debfb55a76ecdb08491181dcb29626" "569bc616c09c389761622ca5be12031dcd7a0fe4c28b1b7154242812b694318c" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "f6665ce2f7f56c5ed5d91ed5e7f6acb66ce44d0ef4acfaa3a42c7cfe9e9a9013" "5784d048e5a985627520beb8a101561b502a191b52fa401139f4dd20acb07607" "3d54650e34fa27561eb81fc3ceed504970cc553cfd37f46e8a80ec32254a3ec3" "1f1b545575c81b967879a5dddc878783e6ebcca764e4916a270f9474215289e5" "a82ab9f1308b4e10684815b08c9cac6b07d5ccb12491f44a942d845b406b0296" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "1d5e33500bc9548f800f9e248b57d1b2a9ecde79cb40c0b1398dec51ee820daf" "613aedadd3b9e2554f39afe760708fc3285bf594f6447822dd29f947f0775d6c" "f91395598d4cb3e2ae6a2db8527ceb83fed79dbaf007f435de3e91e5bda485fb" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "a9a67b318b7417adbedaab02f05fa679973e9718d9d26075c6235b1f0db703c8" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "c3e6b52caa77cb09c049d3c973798bc64b5c43cc437d449eacf35b3e776bf85c" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" "e6f3a4a582ffb5de0471c9b640a5f0212ccf258a987ba421ae2659f1eaa39b09" "850bb46cc41d8a28669f78b98db04a46053eca663db71a001b40288a9b36796c" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "c95813797eb70f520f9245b349ff087600e2bd211a681c7a5602d039c91a6428" "31f1723fb10ec4b4d2d79b65bcad0a19e03270fe290a3fc4b95886f18e79ac2f" "feb8e98a8a99d78c837ce35e976ebcc97abbd8806507e8970d934bb7694aa6b3" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659" "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "2ce76d65a813fae8cfee5c207f46f2a256bac69dacbb096051a7a8651aa252b0" "11cc65061e0a5410d6489af42f1d0f0478dbd181a9660f81a692ddc5f948bf34" "9cd57dd6d61cdf4f6aef3102c4cc2cfc04f5884d4f40b2c90a866c9b6267f2b3" "d9a28a009cda74d1d53b1fbd050f31af7a1a105aa2d53738e9aa2515908cac4c" "f00a605fb19cb258ad7e0d99c007f226f24d767d01bf31f3828ce6688cbdeb22" "d516f1e3e5504c26b1123caa311476dc66d26d379539d12f9f4ed51f10629df3" "6128465c3d56c2630732d98a3d1c2438c76a2f296f3c795ebda534d62bb8a0e3" "3c7a784b90f7abebb213869a21e84da462c26a1fda7e5bd0ffebf6ba12dbd041" "e0628ee6c594bc7a29bedc5c57f0f56f28c5b5deaa1bc60fc8bd4bb4106ebfda" "5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea" "6df412e59dbfe7f72f24319b9ee4513e40bb0e44384fc93a2c77399e641348f6" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "e266d44fa3b75406394b979a3addc9b7f202348099cfde69e74ee6432f781336" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" default))
 '(default-input-method "greek")
 '(diff-hl-show-hunk-posframe-internal-border-color "#357535753575")
 '(display-time-format "%A %H:%M %b %e")
 '(doom-modeline-mode t)
 '(evil-emacs-state-cursor '("#E57373" hbar))
 '(evil-insert-state-cursor '("#E57373" bar))
 '(evil-normal-state-cursor '("#FFEE58" box))
 '(evil-visual-state-cursor '("#C5E1A5" box))
 '(exwm-floating-border-color "#646464")
 '(fci-rule-color "#32302f")
 '(flymake-error-bitmap '(flymake-double-exclamation-mark modus-themes-fringe-red))
 '(flymake-note-bitmap '(exclamation-mark modus-themes-fringe-cyan))
 '(flymake-warning-bitmap '(exclamation-mark modus-themes-fringe-yellow))
 '(highlight-changes-colors '("#d3869b" "#b16286"))
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   '("#522b41fa2b3b" "#3822432737ec" "#5bbf348b2bf5" "#483e36c83def" "#43c0418329b9" "#538f3624267a" "#317a3ddc3e5e"))
 '(highlight-symbol-foreground-color "#bdae93")
 '(highlight-tail-colors
   '(("#32302f" . 0)
     ("#747400" . 20)
     ("#2e7d33" . 30)
     ("#14676b" . 50)
     ("#a76e00" . 60)
     ("#a53600" . 70)
     ("#9f4d64" . 85)
     ("#32302f" . 100)))
 '(hl-bg-colors
   '("#a76e00" "#a53600" "#b21b0a" "#9f4d64" "#8b2a58" "#14676b" "#2e7d33" "#747400"))
 '(hl-fg-colors
   '("#282828" "#282828" "#282828" "#282828" "#282828" "#282828" "#282828" "#282828"))
 '(hl-paren-colors '("#689d6a" "#d79921" "#458588" "#b16286" "#98971a"))
 '(hl-todo-keyword-faces
   '(("HOLD" . "#c0c530")
     ("TODO" . "#feacd0")
     ("NEXT" . "#b6a0ff")
     ("THEM" . "#f78fe7")
     ("PROG" . "#00d3d0")
     ("OKAY" . "#4ae2f0")
     ("DONT" . "#70b900")
     ("FAIL" . "#ff8059")
     ("BUG" . "#ff8059")
     ("DONE" . "#44bc44")
     ("NOTE" . "#d3b55f")
     ("KLUDGE" . "#d0bc00")
     ("HACK" . "#d0bc00")
     ("TEMP" . "#ffcccc")
     ("FIXME" . "#ff9077")
     ("XXX+" . "#ef8b50")
     ("REVIEW" . "#6ae4b9")
     ("DEPRECATED" . "#bfd9ff")))
 '(ibuffer-deletion-face 'modus-themes-mark-del)
 '(ibuffer-filter-group-name-face 'modus-themes-pseudo-header)
 '(ibuffer-marked-face 'modus-themes-mark-sel)
 '(ibuffer-title-face 'default)
 '(icomplete-mode t)
 '(ido-everywhere t)
 '(ido-ubiquitous-mode t)
 '(jdee-db-active-breakpoint-face-colors (cons "#f1ece4" "#7382a0"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f1ece4" "#81895d"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f1ece4" "#b9a992"))
 '(lsp-java-theme "solarized")
 '(lsp-ui-doc-border "#bdae93")
 '(make-backup-files t)
 '(mlscroll-in-color "#56bc56bc56bc")
 '(mlscroll-out-color "#424242")
 '(nrepl-message-colors
   '("#fb4933" "#d65d0e" "#d79921" "#747400" "#b9b340" "#14676b" "#689d6a" "#d3869b" "#b16286"))
 '(objed-cursor-color "#955f5f")
 '(org-src-block-faces 'nil)
 '(package-selected-packages
   '(metronome olivetti-mode notmuch olivetti consult futhark-mode dracula-theme forge solo-jazz-theme gdscript-mode all-the-icons-completion doom-modeline lsp-mode helm-lsp all-the-icons lsp-ui lsp-java java-snippets tuareg flycheck cwl-mode snakemake-mode dockerfile-mode rtags-xref dream-theme org-bullets evil-embrace scala-mode zenburn-theme yasnippet-snippets yapfify wrap-region w3m use-package tramp tommyh-theme sublime-themes subatomic-theme soothe-theme solarized-theme smex seti-theme rainbow-mode rainbow-delimiters pythonic python-docstring python pydoc projectile phoenix-dark-pink-theme pdf-tools paredit panda-theme organic-green-theme org nord-theme noctilux-theme nix-mode multiple-cursors multi move-text monokai-theme monokai-pro-theme monokai-alt-theme molokai-theme moe-theme modus-vivendi-theme modus-operandi-theme magit kosmos-theme kaolin-themes jedi jazz-theme ido-completing-read+ hindent helm-xref helm-tramp helm-swoop helm-gtags helm-git-grep helm-git helm-cscope helm-codesearch haskell-tab-indent haskell-snippets gruvbox-theme gruber-darker-theme git-timemachine gif-screencast gh-md ggtags frame-local flatland-theme flatland-black-theme firecode-theme evil-numbers eshell-syntax-highlighting emmet-mode embrace elpy doom-themes djvu direx-grep dash-functional company-ycmd company-posframe company-jedi company-ghci company-ctags company-c-headers company-auctex clang-capf cl-libify bash-completion avy auctex-latexmk ample-zen-theme ample-theme all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-ibuffer all-the-icons-gnus all-the-icons-dired alect-themes agda2-mode afternoon-theme))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(pos-tip-background-color "#32302f")
 '(pos-tip-foreground-color "#bdae93")
 '(projectile-mode t nil (projectile))
 '(rustic-ansi-faces
   ["#f7f3ee" "#955f5f" "#81895d" "#957f5f" "#7382a0" "#9c739c" "#5f8c7d" "#605a52"])
 '(smartrep-mode-line-active-bg (solarized-color-blend "#98971a" "#32302f" 0.2))
 '(tabbar-background-color "#357535753575")
 '(term-default-bg-color "#282828")
 '(term-default-fg-color "#a89984")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#fb4933")
     (40 . "#eb7b77d92bd4")
     (60 . "#e21f8997270c")
     (80 . "#d79921")
     (100 . "#c322997b1eac")
     (120 . "#b8ad99351d7c")
     (140 . "#ae1f98cc1c53")
     (160 . "#a37098421b33")
     (180 . "#98971a")
     (200 . "#8bd799a13aed")
     (220 . "#84859aa247c0")
     (240 . "#7c5c9ba253bb")
     (260 . "#731d9ca05f39")
     (280 . "#689d6a")
     (300 . "#5cb893d076ee")
     (320 . "#55e98efd7ced")
     (340 . "#4e358a3982c9")
     (360 . "#458588")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#282828" "#32302f" "#b21b0a" "#fb4933" "#747400" "#98971a" "#a76e00" "#d79921" "#14676b" "#458588" "#9f4d64" "#d3869b" "#2e7d33" "#689d6a" "#a89984" "#282828"))
 '(whitespace-style
   '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark))
 '(xterm-color-names
   ["#32302f" "#fb4933" "#98971a" "#d79921" "#458588" "#d3869b" "#689d6a" "#a89984"])
 '(xterm-color-names-bright
   ["#282828" "#d65d0e" "#7c6f64" "#282828" "#a89984" "#b16286" "#bdae93" "#fbf1c7"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(whitespace-big-indent ((t nil)))
 '(whitespace-indentation ((t nil))))
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'suspend-frame 'disabled nil)
