;; ----- window management ----

;; -- the simplest that I found - works with 1 layout only but works!
;; AS - below is actually NOT necessary - there are desktop-xxxx commands
;; which are part of standard emacs distribution.

;; (add-to-list 'load-path "~/asshared/.emacs.d/elpa/layout-restore-0.4")
;; (require 'layout-restore)
;; (global-set-key [?\C-c ?l] 'layout-save-current)
;; (global-set-key [?\C-c ?\C-l ?\C-l] 'layout-restore)
;; (global-set-key [?\C-c ?\C-l ?\C-c] 'layout-delete-current)

;; ------------------------ C / Cpp mode -------------------

(add-hook 'c-mode-common-hook 'auto-complete-mode)


;;------------------------org mode ----------------------------------

(setq backup-directory-alist `(("." . "~/org/emacs.org.backups")))

;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;(defun shk-fix-inline-images ()
;  (when org-inline-image-overlays
;    (org-redisplay-inline-images)))

(setq org-ditaa-jar-path "~/asshared/emacs addons/ditaa0_9/ditaa0_9.jar")
(setq org-plantuml-jar-path "~/asshared/emacs addons/plantuml.jar")

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (sh . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

(add-hook 'org-mode-hook 'auto-complete-mode)


;;----------------------- erlang environment settings start ----------

(setq load-path (cons "/usr/local/OTP_174/lib/tools-2.7.1/emacs" load-path))
(setq erlang-root-dir "/usr/local/OTP_174")
(add-to-list 'exec-path "/usr/local/OTP_174/bin")
(setq erlang-man-root-dir "/usr/local/OTP_174/man")

(setq exec-path (cons "/usr/local/OTP_174/bin" exec-path))
(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

(require 'erlang-start)

;; ---------------erlang -------------------- distel ----------

;; prevent annoying hang-on-compile
(defvar inferior-erlang-prompt-timeout t)
;; tell distel to default to that node
(setq erl-nodename-cache
      (make-symbol
       (concat
        "emacs@"
        ;; Mac OS X uses "name.local" instead of "name" - solution should work for Linux as well
        (car (split-string (shell-command-to-string "hostname"))))))

(add-to-list 'load-path "~/asshared/emacs addons/distel/elisp")
  (require 'distel)
(distel-setup)

;; ---end-------------------------------- distel ----------



;; -------erlang ---------- edts ------------------

;;'(edts-man-root "~/.emacs.d/edts/doc/R7B")

;;(add-hook 'after-init-hook 'my-after-init-hook)
;;(defun my-after-init-hook ()
;;  (require 'edts-start))


;; ---end-------------- edts ------------------



;;-------------- white space and tabulation settings ------
;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; trailing whitespaces
(setq whitespace-line-column 120 whitespace-style '(face tabs trailing lines-tail))

;; activate minor whitespace mode when in python mode
(add-hook 'prog-mode-hook 'whitespace-mode)


;--end--------- white space and tabulation settings ------


(add-to-list 'load-path "~/.emacs.d/elpa/rainbow-delimiters-20150320.17")
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;------ erlang mode hooks --------

(add-hook 'erlang-mode-hook 'rainbow-delimiters-mode)
(add-hook 'erlang-mode-hook 'auto-highlight-symbol-mode)
(add-hook 'erlang-mode-hook 'whitespace-mode)
(add-hook 'erlang-mode-hook 'auto-complete-mode)



;----------------------- erlang environment settings end ----------

(add-to-list 'load-path "~/.emacs.d/elpa/yaml-mode-20141125.37")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;-------------------------- emacs repositories start --------------

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;-------------------------- repositories end  --------------

;-------------------- markdown handling --------------------

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;----end------------ markdown handling --------------------



;--------------------------------- ace window begin ------------


(global-set-key (kbd "M-5") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-dispatch-always t)

;--------------------------------- ace window end ------------

                  ;ace jump mode major function
;--------------------- jump mode begin ---------


;; org-mode hack - restore stolen key-binding
;; AS When org-mode starts it (org-mode-map) overrides the ace-jump-mode - this is a remedy
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "\C-c SPC") 'ace-jump-mode)))


(global-set-key (kbd "C-c SPC") 'avy-goto-word-or-subword-1)

;; AS When org-mode starts it (org-mode-map) overrides the ace-jump-mode - this is a remedy
(add-hook 'org-mode-hook
	  (lambda ()
	    (local-set-key (kbd "\C-c SPC") 'avy-goto-word-or-subword-1)))


; ----------------------------------- jump mode end -----------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (leuven)))
 '(flymake-allowed-file-name-masks
   (quote
    (("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'" flymake-simple-make-init nil nil)
     ("\\.xml\\'" flymake-xml-init nil nil)
     ("\\.html?\\'" flymake-xml-init nil nil)
     ("\\.cs\\'" flymake-simple-make-init nil nil)
     ("\\.p[ml]\\'" flymake-perl-init nil nil)
     ("\\.php[345]?\\'" flymake-php-init nil nil)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup nil)
     ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup nil)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup nil)
     ("\\.tex\\'" flymake-simple-tex-init nil nil)
     ("\\.idl\\'" flymake-simple-make-init nil nil))))
 '(org-agenda-files
   (quote
    ("~/org/gocd.org" "~/org/expenses.org" "~/org/video_project.org" "~/org/concepts.org")))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


; ---------------- smex -------------shows history of commands

(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))

; --end-------------- smex -------------


;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(setq bookmark-save-flag 1) ; everytime bookmark is changed, automatically save it
