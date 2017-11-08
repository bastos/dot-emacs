;; Package initialization
(package-initialize)
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Package
(require 'all-the-icons)
(require 'exec-path-from-shell)
(require 'evil)
(require 'helm)
(require 'imenu)
(require 'helm-imenu)
(require 'helm-config)
(require 'helm-ag)
(require 'helm-projectile)
(require 'projectile)
(require 'helm-projectile)
(require 'smartparens-config)
(require 'yaml-mode)
(require 'recentf)
(require 'company)
(require 'which-key)
(require 'magit)
(require 'helm-smex)
(require 'helm-flx)
(require 'helm-fuzzier)
(require 'helm-swoop)
(require 'helm-descbinds)
(require 'ruby-electric)
(require 'rbenv)
(require 'inf-ruby)
(require 'helm-dash)
(require 'git-gutter-fringe)
(require 'redo+)
(require 'leuven-theme)
(require 'smart-mode-line)
(require 'neotree)
(require 'flycheck)
(require 'haml-mode)
(require 'dumb-jump)
(require 'auto-package-update)
(require 'apib-mode)
(require 'js2-mode)
(require 'json-mode)
(require 'js2-imenu-extras)
(require 'js2-refactor)
(require 'xref-js2)
(require 'company-flow)
(require 'rjsx-mode)
(require 'ace-window)
(require 'multiple-cursors)

;; Packages
(auto-package-update-maybe)

;; exec-path-from-shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Disable JS Hint
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; JS2
(setq
 js2-mode-show-strict-warnings nil
 js2-mode-show-parse-errors nil
 js-indent-level 2
 js2-basic-offset 2
 js2-strict-trailing-comma-warning nil
 js2-strict-missing-semi-warning nil)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; JS2 Refactorxec
(add-hook 'js2-mode-hook #'js2-refactor-mode)

;; Eslint
(flycheck-add-mode 'javascript-eslint 'rjsx-mode)

;; RJSX
(with-eval-after-load 'rjsx-mode
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil)
  (define-key rjsx-mode-map ">" nil))

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
;; (defun my/use-eslint-from-node-modules ()
;;   (let* ((root (locate-dominating-file
;;                 (or (buffer-file-name) default-directory)
;;                 "node_modules"))
;;          (eslint (and root
;;                       (expand-file-name "node_modules/eslint/bin/eslint.js"
;;                                         root))))
;;     (when (and eslint (file-executable-p eslint))
;;       (setq-local flycheck-javascript-eslint-executable eslint))))
;; (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; Apib mode
(add-to-list 'auto-mode-alist '("\\.apib\\'" . apib-mode))
(add-to-list 'auto-mode-alist '("\\.apib.erb\\'" . apib-mode))

;; Auto revert mode
(global-auto-revert-mode t)

;; Editing settings
(defun bsts/visit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; Initial mode
(setq initial-major-mode (quote text-mode))

;; Neotree
(setq neo-theme 'icons)

;; Theme
(load-theme 'leuven t)

;; Font
(set-frame-font "Monaco 14")

;; Smart mode line
(setq sml/theme 'light)
(setq sml/no-confirm-load-theme t)
(sml/setup)

;; Meta
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;;Fringe
(set-face-attribute 'fringe nil :background "white")

;; Git Gutter
(global-git-gutter-mode +1)
(setq git-gutter-fr:side 'left-fringe)

;; Rbenv settings
(setq rbenv-modeline-function 'rbenv--modeline-plain)
(setq rbenv-show-active-ruby-in-modeline nil)
(global-rbenv-mode)
(rbenv-use-global)

;; Ruby Electric Settings
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

;; Ruby Mode Settings
(add-to-list 'auto-mode-alist
             '("\\.\\(?:cap\\|gemspec\\|builder\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;;; Magit mode (which does not open in evil-mode):
(add-hook 'magit-mode-hook
          (lambda ()
            (define-key magit-mode-map (kbd ",o") 'delete-other-windows)))

;;; Git Commit Mode (a Magit minor mode):
(add-hook 'git-commit-mode-hook 'evil-insert-state)

;; Evil mode
(evil-mode 1)

;; Helm settings
(setq helm-M-x-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t)

(add-hook 'find-file-hook 'helm-save-current-pos-to-mark-ring)

(helm-mode 1)
(helm-flx-mode 1)
(helm-fuzzier-mode 1)

;; Move to trash when deleting stuff
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

;; Right Alt set to none, this is useful to write accents like Alt+n a -> ã.
(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'none))

;; Kill current buffer
(defun bsts/kill-current-buffer ()
  "Kill the current buffer without prompting."
  (interactive)
  (kill-buffer (current-buffer)))

;; Projectile
(setq frame-title-format '((:eval (projectile-project-name))))
(setq projectile-enable-caching t)
(projectile-mode t)

;; Parenthesis
(show-paren-mode 1)

;; Scrolling
(when window-system
  (scroll-bar-mode -1))

;;line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(global-linum-mode t)

;; History
(setq history-length 1000)
(savehist-mode 1)

;; Recent Files
(setq recentf-max-saved-items 100)
(recentf-mode 1)

;; which-key-mode
(which-key-mode 1)

;; Flycheck
(global-flycheck-mode)

;; Cursor
(blink-cursor-mode 1)

;; Company
(setq company-minimum-prefix-length 2)
(add-hook 'after-init-hook 'global-company-mode)

;; Whitespaces
(add-hook 'before-save-hook 'whitespace-cleanup)

(fset 'yes-or-no-p 'y-or-n-p)

;; Turn Tabs off
(setq-default indent-tabs-mode nil)

;; Add new line
(setq require-final-newline t)

;; Encoding
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; GUI
(tool-bar-mode -1)
(setq visible-bell t)

;; Linum  size
(setq linum-format "%4d ")
(set-face-attribute 'linum nil :background "gray98")
(set-face-attribute 'linum nil :foreground "gray80")
(setq linum-delay t)

;; Dumb Jump Mode
(setq dumb-jump-selector 'helm)
(dumb-jump-mode)


;; Fill column
(setq fill-column 80)

;; Transpose windows
(defun transpose-windows ()
  "Transpose two windows.  If more or less than two windows are visible, error."
  (interactive)
  (unless (= 2 (count-windows))
    (error "There are not 2 windows"))
  (let* ((windows (window-list))
         (w1 (car windows))
         (w2 (nth 1 windows))
         (w1b (window-buffer w1))
         (w2b (window-buffer w2)))
    (set-window-buffer w1 w2b)
    (set-window-buffer w2 w1b)))

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Rename File
(defun bsts/rename-file (new-name)
  "A convenient way to rename files to `NEW-NAME`."
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

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; autosave the undo-tree history
(setq undo-tree-history-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq undo-tree-auto-save-history t)

;; Shortcuts
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-f") 'isearch-forward)
(global-set-key (kbd "s-g") 'isearch-repeat-forward)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-Z") 'redo)
(global-set-key (kbd "s-l") 'goto-line)
(global-set-key (kbd "s-O") 'occur)
(global-set-key (kbd "M-s-[") 'indent-according-to-mode)
(global-set-key (kbd "s-/") 'comment-line)
(global-set-key (kbd "s-[") 'previous-buffer)
(global-set-key (kbd "s-]") 'next-buffer)
(global-set-key (kbd "C-c e") 'bsts/visit-emacs-config)
(global-set-key (kbd "s-<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C-x k") 'bsts/kill-current-buffer)
(global-set-key (kbd "s-w") 'ace-window)
(global-set-key (kbd "C-x g") 'magit-status)

;; Clipboard
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "s-v") 'clipboard-yank)
(global-set-key (kbd "s-x") 'clipboard-kill-region)

;; Dumb Jump
(global-set-key (kbd "M-g j") 'dumb-jump-go)
(global-set-key (kbd "s-j") 'dumb-jump-go)
(global-set-key (kbd "M-g b") 'dumb-jump-back)

;; Helm
(global-set-key (kbd "s-o") #'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "s-m") #'helm-mini)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)
(global-set-key (kbd "s-b") #'helm-buffers-list)
(global-set-key (kbd "s-y") 'helm-show-kill-ring)
(global-set-key (kbd "s-t") #'helm-projectile-find-file)
(global-set-key (kbd "s-p") #'helm-projectile-find-file)
(global-set-key [remap execute-extended-command] #'helm-smex)
(global-set-key (kbd "M-X") #'helm-smex-major-mode-commands)
(global-set-key (kbd "s-'") 'helm-swoop)
(global-set-key (kbd "s-i") 'helm-imenu)
(global-set-key (kbd "s-I") 'helm-imenu-in-all-buffers)
(global-set-key (kbd "s-F") 'helm-ag-project-root)

;; multi-cursors.el
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "s-<down>") 'mc/mark-next-like-this)
(global-set-key (kbd "s-<up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(define-key mc/keymap (kbd "<return>") nil)

;; Mouse bindings
(global-set-key (kbd "s-<mouse-1>") 'mc/add-cursor-on-click)

;; Aliases
(defalias 'rs 'replace-string)

;; custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
