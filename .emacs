
(if window-system
  (tool-bar-mode -1))

(setq ring-bell-function 'ignore)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(require 'cl)
(setq custom-safe-themes t)
(load-theme 'labburn)

(add-to-list 'load-path "~/.emacs.d/manual-downloads/")

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("83faf27892c7119f6016e3609f346d3dae3516dede8fd8a5940373d98f615b4e" "f5512c02e0a6887e987a816918b7a684d558716262ac7ee2dd0437ab913eaec6" "091919105399907867eb722eca685102529fe8afb6840800750dcd2bab63d0b2" default)))
 '(package-selected-packages
   (quote
    (anki-editor helm-ag tj-mode web-mode json-mode recentf-ext labburn-theme zenburn-theme org-trello evil cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; LHF == "Low-Hanging Fruit"
; BFP == "Big Fucking Problem"
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
