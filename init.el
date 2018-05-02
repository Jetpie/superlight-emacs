;;;; DESCRIPTION
;;;;
;;;; A super light-weighted emacs one-page conifg that implemented 
;;;; minimum requirement of programming
;;;;
;;;; Brief Function List:
;;;; * Theme Setting
;;;;   - zenburn
;;;; * Basic and Classical GUI Setting
;;;;   -
;;;;
;;;; LICENSE

;;;; AUTHOR : Bingqing Qu

;;;;;;;;;;;;; LET'S START FROM HERE ;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Operating System Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-a-linux* (eq system-type 'gnu/linux))
(defconst *is-a-win* (eq system-type 'ms-dos))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs *package* Function Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
;;; Standard package repositories
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;;; Also use Melpa for most packages
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;;; I "stole" this function from purcell's popular setting (https://github.com/purcell/emacs.d)
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))


(setq package-enable-at-startup nil)
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Theme Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; global theme
(require-package 'zenburn-theme)
(load-theme 'zenburn t)

;; ;;; bottom line
;; (require 'cl)
;; (require-package 'powerline)
;; (powerline-vim-theme)
;; (setq powerline-default-separator 'wave)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs GUI Style Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq frame-title-format "emacs")

;;; suppress menu/tool/scroll bar modes
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;; suppress start-up screen
(require-package 'scratch)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)
(if (fboundp 'fringe-mode)
    (fringe-mode 4))

;;; cursor setting
(set-default 'cursor-type 'box)
(set-cursor-color "#ffffff")
(blink-cursor-mode 0)

;;; parenthesis highlight
(show-paren-mode t)

;;; Line Setting
;; highlight
(require-package 'highlight-current-line)
(global-hl-line-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "brightblack" :underline t)))))

;; line numbers
(line-number-mode t)
(global-linum-mode t)
(require-package 'nlinum)
(nlinum-mode t)

;; wrap line
(visual-line-mode t)

;;; Column Setting
(column-number-mode t)

(winner-mode t)
(windmove-default-keybindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Functionality
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'yes-or-no-p 'y-or-n-p)
;;; ido mode and smex
(require 'ido)
(ido-mode t)

(require-package 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; switch window
(require-package 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; auto-complete
(require-package 'auto-complete)
;; (ac-config-default t)

;;; autopair
(require-package 'autopair)
(autopair-global-mode t)

;;; undo-tree
(require-package 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-visualize)

;;; ace-jump-mode
(require-package 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
;; (global-set-key (kbd "C-:") 'ace-jump-word-mode)

;;; 80/100 column indicator
(require-package 'column-enforce-mode)
(global-column-enforce-mode t)
(setq column-enforce-column 100)
;; active this if comment is excluded
(setq column-enforce-comments nil)

;;; multiple-cursors
(require-package 'multiple-cursors)
(global-set-key (kbd "C-c >") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c <") 'mc/mark-previous-like-this)

;;; delete-selection-mode
;; If you enable Delete Selection mode, a minor mode, then inserting text while the mark is active
;; causes the selected text to be deleted first.
(delete-selection-mode t)

;;-----------------------------------------------------------------------------------------------
;;-----------------------------------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; Programming Languages GLOBAL SETTING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq global-mark-ring-max 5000         ; increase mark ring to contains 5000 entries
      mark-ring-max 5000                ; increase kill ring to contains 5000 entries
      mode-require-final-newline t      ; add a newline to end of file
      tab-width 4                       ; default to 4 visible spaces to display a tab
      )
(setq kill-ring-max 5000 ; increase kill-ring capacity
      kill-whole-line t  ; if NIL, kill whole line and move the next line up
      )

;;; automatically indent when press RET
(global-set-key (kbd "RET") 'newline-and-indent)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; C++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; clean-aindent-mode
(require-package 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;;; dtrt-indent
;; An Emacs minor mode that guesses the indentation offset originally used for creating source code files and transparently
;; adjusts the corresponding settings in Emacs, making it more convenient to edit foreign files.
(require-package 'dtrt-indent)
(dtrt-indent-mode 1)
(setq dtrt-indent-verbosity 0)

;; ws-butler
(require-package 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "ellemtel")
(setq-default c-basic-offset 4)

;;; set namespace no indent
(defun namespace-no-indent ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'namespace-no-indent)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'python-mode)
; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

;;----------------------------------------------------------------------------------------------
;;----------------------------------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (multiple-cursors column-enforce-mode ace-jump-mode switch-window powerline undo-tree autopair nlinum auto-complete-config auto-complete smex zenburn-theme popup highlight-current-line))))