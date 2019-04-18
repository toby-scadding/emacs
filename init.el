;; load emacs 24's package system. Add MELPA repository.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit beacon smex smartparens company-phpactor phpactor company ace-window php-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(eval-when-compile
  (add-to-list 'load-path "elpa")
  (require 'use-package))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(load-theme 'tango-dark)

(require 'ido)
(ido-mode t)

(global-set-key (kbd "M-o") 'ace-window)

(global-linum-mode 1)
(setq linum-format "%d ")

(add-hook 'before-save-hook 'my-prog-nuke-trailing-whitespace)

(defun my-prog-nuke-trailing-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

(add-hook 'after-init-hook 'global-company-mode)
(setq company-dabbrev-downcase 0)

(use-package phpactor)
(use-package company-phpactor
  :after company)

(setq company-idle-delay 0.1)

(use-package php-mode
  :ensure t
  :init
  (defun my/php-mode-hook ()
    (set (make-local-variable 'company-backends)
          '(company-phpactor
            company-dabbrev-code
            company-files)))
  :hook
  (php-mode . my/php-mode-hook))

(add-hook 'php-mode-hook
	  (lambda () (local-set-key (kbd "M-.") #'phpactor-goto-definition)))

(require 'smartparens-config)
(add-hook 'prog-mode-hook #'smartparens-mode)

(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(when (fboundp 'winner-mode)
  (winner-mode 1))

(column-number-mode 1)

(beacon-mode 1)
(global-set-key (kbd "C-c C-b") 'beacon-blink)

(setq vc-handled-backends nil)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)
