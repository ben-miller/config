(require 'package)
(push '("melpa" . "http://melpa.org/packages/")
        package-archives )

(package-initialize)

(require 'cl)

(setq home-directory "/Users/bmiller/")
(setq org-directory (concat home-directory "life/"))

;(load (concat home-directory ".emacs.d/lib/transpose-frame.el"))
;(load (concat home-directory ".emacs.d/lib/move-text.el"))

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)

(setq journal-directory (concat org-directory ".archived/journal-entries"))
(defun journal-entry ()
  (interactive)
  "Create or edit journal entry"
  (progn (make-directory (concat journal-directory "/"
				 (format-time-string "%Y/%m")) t)
	 (find-file (concat journal-directory (format-time-string "/%Y-%m-%d.org")))
	 (if (= (buffer-size) 0)
           (progn (insert (format-time-string "%A, %B %e, %Y"))
                  (insert-file-contents (concat org-directory "journal-template.org"))))))


(setq notes-directory (concat org-directory "notes"))
(defun notes-entry ()
  (interactive)
  "Go to weekly notes"
     (find-file (concat notes-directory (format-time-string "/%Y-week%U.org"))))

(setq origo-notes-directory (concat home-directory "origo/hopi-core/bmiller"))
(defun origo-notes-entry ()
  (interactive)
  "Go to weekly Origo notes"
     (find-file (concat origo-notes-directory (format-time-string "/%Y-week%U.org"))))

(format-time-string "%U")

(global-set-key "\C-cj" 'journal-entry)
(global-set-key "\C-cn" 'notes-entry)
(global-set-key "\C-co" 'origo-notes-entry)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

(if window-system
    (progn
      (tool-bar-mode 0)
      (setq inhibit-startup-message t)
      (find-file (concat org-directory "projects.org"))
      (setq inhibit-startup-message t)
      (split-window-right)
      (other-window 1)))

(add-to-list 'auto-mode-alist '("/Users/bmiller/src/dotfiles/emacs" . emacs-lisp-mode))

(setq require-final-newline t)

(setq org-startup-indented t)
(setq org-indent-mode t)

(setq scroll-step 1)
(setq scroll-margin 1)

(menu-bar-mode -1)
(setq vc-follow-symlinks t)
(setq inhibit-startup-message t)

(define-key input-decode-map "\033\033[1;10A" [S-M-up])
(define-key input-decode-map "\033\033[1;10B" [S-M-down])
(define-key input-decode-map "\033\033[1;10C" [S-M-right])
(define-key input-decode-map "\033\033[1;10D" [S-M-left])
