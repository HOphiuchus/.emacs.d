;;24.4
(desktop-save-mode 1)
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq url-proxy-services '(("no_proxy" . "work\\.com")
                           ("http" . "httphost:3128")))
;;#########################;;#########################
;; init
(menu-bar-mode -1);;
(if (display-graphic-p)
        (progn
(tool-bar-mode -1);;since emacs24 nil means enable, before means toggle
));;
(setq inhibit-startup-message t)
(column-number-mode t)
;;(global-linum-mode t)
(transient-mark-mode t)
(global-set-key (kbd "C-c n") 'linum-mode) 
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(global-font-lock-mode t)
(ido-mode t)
(setq org-startup-indented-mode t)
(add-to-list 'load-path "~/.emacs.d/script")
(add-to-list 'load-path "~/.emacs.d/others/")


;:********
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
					; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;#########################;;#########################
;; load ac
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

(if (>= emacs-major-version 24)
    (progn
      (add-to-list 'load-path "~/.emacs.d/git-modes")
      (require 'git-commit-mode)
      (require 'git-rebase-mode)

      (add-to-list 'load-path "~/.emacs.d/magit")

      (require 'magit)
      (setq magit-last-seen-setup-instructions "1.4.0")
      ))

;;#########################;;#########################
;; tcl
(setq tcl-application "tclsh")

;;#########################;;#########################
;; load tramp
(setq tramp-default-method "plink")
(setq tramp-auto-save-directory "~/temp")

;;#########################
;;cperl mode
(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook 'flymake-mode)
(require 'perltidy)

;;#########################
;;php mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;;#########################
;; sr-speedbar
;; (require 'sr-speedbar)
;; (setq speedbar-show-unknown-files t)
;; (setq sr-speedbar-right-side nil)
;; (add-hook 'emacs-startup-hook 
;; 	  (lambda ()
;; 	    (sr-speedbar-open)
;; 	    )
;; 	  )
;;#########################;;#########################
;; set flymake with pylint and pep8
(if (eq system-type 'windows-nt)
    (when (load "flymake" t)
      (defun flymake-pycheckers-init ()
	(let* ((temp-file (flymake-init-create-temp-buffer-copy
			   'flymake-create-temp-inplace))
	       (local-file (file-relative-name
			    temp-file
			    (file-name-directory buffer-file-name))))
	  (list "~/.emacs.d/script/pychecker.bat" (list local-file))))
      
      (add-to-list 'flymake-allowed-file-name-masks
		   '("\\.py\\'" flymake-pycheckers-init))
      (add-hook 'python-mode-hook 'flymake-mode)
      )
  (when (load "flymake" t)

    (defun flymake-pycheckers-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
			 'flymake-create-temp-inplace))
	     (local-file (file-relative-name
			  temp-file
			  (file-name-directory buffer-file-name))))
	(list "epylint" (list local-file))))
    
    (add-to-list 'flymake-allowed-file-name-masks
		 '("\\.py\\'" flymake-pycheckers-init))
    (add-hook 'python-mode-hook 'flymake-mode)
    )
  )

;; flymake for perl
(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc " local-file))))
(setq flymake-allowed-file-name-masks
      (cons '(".+\\.pl$"
	      flymake-perl-init
	      flymake-simple-cleanup
	      flymake-get-real-file-name)
	    flymake-allowed-file-name-masks))

(setq flymake-err-line-patterns
      (cons '("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]"
	      2 3 nil 1)
	    flymake-err-line-patterns))

;; flymake for sh
(if (eq system-type 'gnu/linux)
    (when (load "flymake" t)
      (defun flymake-shell-init ()
	(let* ((temp-file (flymake-init-create-temp-buffer-copy
			   'flymake-create-temp-inplace))
	       (local-file (file-relative-name
			    temp-file
			    (file-name-directory buffer-file-name))))
	  (list "bash" (list "-n" local-file))))
      
      (add-to-list 'flymake-allowed-file-name-masks
		   '("\\.sh$" flymake-shell-init))
      (add-hook 'sh-mode-hook 'flymake-mode)
      )
  )



(global-set-key (kbd "C-c m") 'flymake-mode)  
(require 'flymake-cursor)


;;#########################;;#########################
;; theme solarized
(if (>= emacs-major-version 24)
    (progn
      (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
      (if (eq system-type 'windows-nt)
	  (load-theme 'solarized-dark t)
	)
      )
  )

;;#########################;;#########################
;;(autoload 'tt-mode "tt-mode")
(require 'tt-mode)
(add-to-list 'auto-mode-alist '("\\.tt$" . tt-mode))

(require 'cedet)

;;#########################;;#########################
;; include others
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.php$'" . web-mode))
(setq web-mode-tag-auto-close-style 1)


;;#########################;;#########################
;; auxtex

(add-to-list 'load-path
	     "~/.emacs.d/auctex/site-lisp/site-start.d")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(if (eq system-type 'windows-nt)
    (require 'tex-mik))
(mapc (lambda (mode)
	(add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
	    'LaTeX-math-mode
	    'turn-on-reftex
	    'linum-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "yellow"])
 '(background-color nil)
 '(background-mode dark)
 '(cursor-color nil)
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(foreground-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
