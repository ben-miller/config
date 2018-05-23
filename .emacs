;(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(require 'cl)
(setq custom-safe-themes t)
(load-theme 'labburn)

(setq home-directory "/Users/bmiller/")
(setq org-directory (concat home-directory "life/"))
(setq org-agenda-files '("~/notes/"))
(setq journal-directory (concat org-directory "notes/journal/"))
(setq thoughts-directory (concat org-directory "notes/thoughts/"))
(setq daily-iteration-directory (concat org-directory "notes/journal/daily-iterations"))
(setq weekly-log-directory (concat org-directory "notes/weekly/"))

(defun thoughts-entry ()
  (interactive)
  "Create or edit thoughts entry"
  (progn 
	 (find-file (concat thoughts-directory (format-time-string "/%Y-%m-%d.org")))
	 (if (= (buffer-size) 0)
           (progn (insert (format-time-string "%A, %B %e, %Y"))))))

(defun daily-header ()
  (interactive)
  (insert (format-time-string "* %Y-%m-%d")))

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(setq require-final-newline t)
(setq org-startup-indented t)
(setq org-indent-mode t)
(setq scroll-step 1)
(setq scroll-margin 1)
(menu-bar-mode -1)
(setq vc-follow-symlinks t)
(setq inhibit-startup-message t)
(setq vc-follow-symlinks t)
(setq inhibit-startup-message t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(if window-system
  (tool-bar-mode -1))

(setq ring-bell-function 'ignore)


(setq org-todo-keywords '((sequence "LHF" "BFP" "TODO" "DONE")))

(defun notes-dir ()
  (interactive)
  "Go to notes directory"
  (dired "~/notes")
)

(define-key global-map "\C-cn" 'notes-dir)
(if window-system
  (find-file "~/notes"))

(setq auto-save-file-name-transforms
  `((".*" "~/.emacs-saves/" t)))

(define-key input-decode-map "\033\033[1;10A" [S-M-up])
(define-key input-decode-map "\033\033[1;10B" [S-M-down])
(define-key input-decode-map "\033\033[1;10C" [S-M-right])
(define-key input-decode-map "\033\033[1;10D" [S-M-left])
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (orgbox orgnav org-parser org labburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
