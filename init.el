;; .Emacs file for Nelson Ingersoll
;;
;; Set up my key bindings.
;;
;; NOTE: Nelson, you can test changes while still editing the .emacs
;;       buffer by issuing the meta-X command eval-buffer which will
;;       compile the buffer and make all changes available.
;;       Thu 2003.07.31 10:48:12 NEI
;;
;;============================================================================
;; Windows font notes:
;;     Quick-n-dirty way to pick and set/test new fonts in Windows.
;;
;;  Execute this (insert (prin1-to-string (w32-select-font))) in the
;;  *scratch* buffer.  Select a font.  Take the resulting string and
;;  put it in place of the XXXXX in the following string:
;;
;;   (set-default-font XXXXX )
;;
;;  and execute that code.  That will set the default font.
;;
;;============================================================================

(message "\n==========================================================")
(message "Starting Nelson's init.el")
(message "==========================================================")
(message         "Op System:   %s" system-type)
(message         "System Name: %s" system-name)
(message (concat "TERMinal:    " (getenv "TERM")))
(message "==========================================================\n")

;; Start the Emacs server, unless the server is already running.
(require 'server)
(unless (server-running-p)
  (cond
   ((eq system-type 'windows-nt)
    (setq server-auth-dir "~\\.emacs.d\\server\\"))
   ((eq system-type 'gnu/linux)
    (setq server-auth-dir "~/.emacs.d/server/")))
  (setq server-name "emacs-server-file")
  (server-start))

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

; Use Unix line endings by default!
(setq default-buffer-file-coding-system 'utf-8-unix)

(require 'package)
(package-initialize)
;The gnu package-archive is automatically part of the variable package-archives.
;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; This is where I put my personal lisp files.
(add-to-list 'load-path "~/.emacs.d/elisp")

;; This is where 'local' Info files are put.
(add-to-list 'Info-default-directory-list "~/.emacs.d/info")

;; Initial mode.
(setq major-mode 'text-mode)
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))

(tool-bar-mode -1)   ; Do we like the toolbar?  NO!

;; Miscellaneous startup settings.
(setq inhibit-startup-message t)
(setq user-mail-address "nelson_ingersoll@email.com")
(setq user-full-name "Nelson E. Ingersoll")

(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)
(setq tab-width 3) ; or any other preferred value


;; ============== Specific key-sequences for Nelson! ==============
(global-set-key "\C-b" 'backward-word)
(global-set-key "\C-f" 'forward-word)
(global-set-key "\C-cf" 'find-file-at-point)
(global-set-key "\C-x\C-i" 'insert-file)
(global-set-key "\C-\\" 'delete-trailing-whitespace)
(global-set-key "\M-\\" 'delete-horizontal-space)

;; uniquify-region from
;;   http://everything2.com/title/useful%2520emacs%2520lisp%2520functions
(defun uniquify-region ()
  "remove duplicate adjacent lines in the given region"
  (interactive)
  (narrow-to-region (region-beginning) (region-end))
  (beginning-of-buffer)
  (while (re-search-forward "\\(.*\n\\)\\1+" nil t)
    (replace-match "\\1" nil nil))
  (widen)
  nil
)

(put 'narrow-to-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Insert a date/time stamp at point.
;; Picked up code fragment in USENET group "comp.emacs.xemacs".
(setq nei-datetime-format "%Y.%m.%d %H:%M")
(setq nei-time-format "%l:%M %P")
(defun insert-datetime-here ()
  (interactive)
  (insert (format-time-string nei-datetime-format)))
;;
(defun insert-time-here ()
  (interactive)
  (insert (format-time-string nei-time-format)))
(global-set-key "\C-x\\" 'insert-datetime-here)
(global-set-key "\C-x\|" 'insert-time-here)
;; --- end Setup special date/time bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Frame controls.
(require 'nei-frame-controls)

(global-set-key "\C-cwr" 'nei-restore-window)
(global-set-key "\C-cws" 'nei-remember-frame)
(global-set-key "\C-cwo" (lambda () (interactive)
                           (nei-frame-set 55 300 81 45)))
(global-set-key "\C-cwn" (lambda () (interactive) (nei-frame-set 0 0 80 0)))
(global-set-key "\C-cww" (lambda () (interactive) (nei-frame-set 0 0 133 0)))
(global-set-key "\C-cw3" (lambda () (interactive) (nei-frame-set 0 0 0 35)))
(global-set-key "\C-cw4" (lambda () (interactive) (nei-frame-set 0 0 0 40)))
(global-set-key "\C-cw5" (lambda () (interactive) (nei-frame-set 0 0 0 45)))
(global-set-key "\C-cw6" (lambda () (interactive) (nei-frame-set 0 0 0 50)))
(global-set-key "\C-cwp" (lambda () (interactive) (nei-frame-set 65 4 130 90)))
;;; end Load Frame controls ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Org files location setup
;; Load TODOs.org data file.
(global-set-key [f9] 'nei-open-TODO-file)
(defun nei-open-TODO-file ()
  (interactive)
  (find-file "~/Dropbox/org/DailyLog.org"))

;; Load Projects.org data file.
(global-set-key [f10] 'nei-open-PROJECTS-file)
(defun nei-open-PROJECTS-file ()
  (interactive)
  (find-file "~/Dropbox/org/Projects.org")
)

;; Load Personal.org data file.
(global-set-key [f11] 'nei-open-PERSONAL-file)
(defun nei-open-PERSONAL-filexx ()
  (interactive)
  (find-file "~/Dropbox/org/Personal.org")
)

;; Insert Org-mode "*** timestamp" diary line.
(global-set-key "\C-cv" 'nei-insert-diary-timestamp)
(defun nei-insert-diary-timestamp ()
  (interactive)
  (insert (concat "*** " (format-time-string nei-datetime-format) "; \n" ))
  (move-end-of-line -0)
)
;;### end org-mode setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(set-default-font "DejaVu Sans Mono-11" )
(setq nei-frame-top 65 )
(setq nei-frame-left 300 )
(setq nei-frame-cols 100 )
(setq nei-frame-rows 45 )
(nei-restore-window)

;;## Set up goto last change #################################################
(autoload 'goto-last-change "goto-last-change"
 	  "Set point to the position of the last change." t)
(global-set-key "\C-x?" 'goto-last-change)

(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode `right)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-paren-on-screen t)
 '(case-fold-search t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(current-language-environment "Latin-1")
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(mouse-avoidance-mode (quote jump) nil (avoid))
 '(package-selected-packages
   (quote
    (ranger org-send-ebook org-randomnote org-journal org-easy-img-insert org-download org-cliplink org-bullets org-bookmark-heading org-board ob-nim org-blog org-beautify-theme org-autolist code-library org-chef json-mode solarized-theme)))
 '(perl-tab-to-comment t)
 '(show-paren-mode t nil (paren))
 '(show-paren-mode-hook nil t)
 '(show-paren-style (quote parenthesis))
 '(show-trailing-whitespace t)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style nil nil (uniquify)))
(load-theme  'solarized-dark)

(setq make-backup-files nil) ; No backups.
(setq line-number-mode t)
(setq column-number-mode t)

(autoload 'folding-mode          "folding" "Folding mode" t)
(autoload 'turn-off-folding-mode "folding" "Folding mode" t)
(autoload 'turn-on-folding-mode  "folding" "Folding mode" t)

;;============================================================================
;;============== End standard .emacs - Start OS specific .emacs ==============
;;============================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Windows specific setup values
(defun windows_setup ()
  (message "Executing Windows-NT Emacs initialization")

  (setq ring-bell-function (lambda () (play-sound-file "~/.emacs.d/tick.wav")))

  ;; Set a nice font for Windows
  (set-default-font "DejaVu Sans Mono-11" )

  (if (equal system-name "COQC2LNTOENG074")
      ;; Special case when running emacs on my laptop.

      (progn
        (set-default-font "DejaVu Sans Mono-11" )
        (setq nei-frame-top 55 )
        (setq nei-frame-left 300 )
        (setq nei-frame-cols 81 )
        (setq nei-frame-rows 45 )
        (nei-restore-window)
       )
   )

;;x;;   (add-to-list 'load-path "~/.emacs.d/elisp/EmacsW32/lisp")
;;x;;   (require 'emacsw32)

;;x;;   ; Alt key presses are passed on to Windows.
;;x;;   (setq-default w32-pass-alt-to-system t)

;;x;;   ; Cygwin bin directory location.
;;x;;    (setq w32shell-cygwin-bin "C:/cygwin/bin")

  ; Window look
  (menu-bar-mode 1) ; Turn ON drop down menu.
  (tool-bar-mode 0) ; Turn OFF tool bar.

  ;; Set a nice font for Windows
  (set-default-font "DejaVu Sans Mono-11" )

;;x;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;x;; ;; Tramp nonsense (I hate tramp - too much trouble on Windows.)
;;x;;   (require 'tramp)
;;x;;   ;DBG;(setq tramp-debug-buffer t) ; To debug tramp issues.
;;x;;   ;DBG;(setq tramp-verbose 10)     ; To debug tramp issues.
;;x;;   (setq tramp-default-method "plink")
;;x;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; ISpell
  (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
  (setq ispell-program-name "aspell")
  (require 'ispell)
  (setq ispell-dictionary "english")
  (global-set-key "\C-cs" 'ispell-buffer)
  (global-set-key "\C-cS" 'ispell-region)
  (require 'flyspell)

  ;;====== Don't MESS with the following... please. =======================
  (custom-set-variables
   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
   ;; Your init file should contain only one such instance.
   '(blink-matching-paren-on-screen t)
   '(case-fold-search t)
   '(confirm-kill-emacs (quote y-or-n-p))
   '(current-language-environment "Latin-1")
   '(default-input-method "latin-1-prefix")
   '(global-font-lock-mode t nil (font-lock))
   '(mouse-avoidance-mode (quote jump) nil (avoid))
   '(perl-tab-to-comment t)
   '(show-paren-mode t nil (paren))
   '(show-paren-mode-hook nil)
   '(show-paren-style (quote parenthesis))
   '(show-trailing-whitespace t)
   '(transient-mark-mode t)
   '(uniquify-buffer-name-style nil nil (uniquify))
   )
  ;;---------------------------------------------------------------------------
  (setq default-directory "~/")
  (message "Finished Windows-NT Emacs initialization")
  (message "==========================================================")
)
;; --- end Windows specific setup values ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Unknown setup.   Generally this is *NIX of some flavor.
;;
(defun unknown_setup ()
  (message (concat "Executing 'Unknown' Emacs initialization" system-name) )
  (custom-set-variables
   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
   ;; Your init file should contain only one such instance.
   '(blink-matching-paren-on-screen t)
   '(case-fold-search t)
   '(current-language-environment "Latin-1")
   '(default-input-method "latin-1-prefix")
   '(custom-enabled-themes (quote (solarized-dark)))
   '(global-font-lock-mode t nil (font-lock))
   '(perl-tab-to-comment t)
   '(show-paren-mode t nil (paren))
   '(show-paren-mode-hook nil)
   '(show-paren-style (quote parenthesis))
   '(show-trailing-whitespace t)
   '(transient-mark-mode t)
   '(uniquify-buffer-name-style nil nil (uniquify)))

  ; ISpell
  (setq-default ispell-program-name "/usr/bin/aspell")
  (ispell-change-dictionary "english" t)
  (global-set-key "\C-cs" 'ispell-buffer)
  (global-set-key "\C-cS" 'ispell-region)
  (set-default-font "DejaVu Sans Mono-11" )
  (message "Finished 'Unknown' Emacs initialization")
  (message "==========================================================")
)
;; End Unknown setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Now, figure out the OS and run special setup accordingly.
(if (equal system-type 'windows-nt )
    (progn
      (message "Windows-NT")
      (windows_setup))
  (unknown_setup)
)

(message "Finished Nelson's init.el")
(message "==========================================================")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
