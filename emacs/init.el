;;; init --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs

;; Custom

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 ;; 화면
 '(column-number-mode t) ; 아래 쪽에 컬럼 넘버 뜸

 '(display-time-mode t) ; 아래 쪽에 시간 뜸

 ;; coq 경로

 '(coq-prog-name "/Users/kyeongmin.cho/.opam/ocaml-variants/bin/coqtop") ; !경로!

 '(exec-path-from-shell-variables (quote ("PATH" "MANPATH" "SHELL")))
 '(magit-emacsclient-executable "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient") ; !경로!

 '(package-selected-packages (quote (ein proof-general edit-server edts company-erlang
                                         vue-html-mode cargo tuareg hc-zenburn-theme
                                         scala-mode rust-mode paredit paradox markdown-mode
                                         magit iy-go-to-char flycheck-rust flycheck-ocaml
                                         flycheck-haskell flycheck-google-cpplint flycheck-color-mode-line
                                         exec-path-from-shell el-autoyas company-coq
                                         coffee-mode auctex angular-snippets undo-tree)))
 '(proof-three-window-mode-policy (quote hybrid))
 '(safe-local-variable-values (quote ((TeX-command-extra-options . "-shell-escape")
                                      (eval flet
                                            ((pre (s)
                                                  (concat (locate-dominating-file buffer-file-name ".dir-locals.el")
                                                          s)))
                                            (setq coq-load-path (\`((rec (\,(pre "lib/sflib"))
                                                                         "sflib")
                                                                    (rec (\,(pre "lib/paco/src"))
                                                                         "Paco")
                                                                    (rec (\,(pre "lib/hahn"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/axiomatic"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/lib"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/opt"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/prop"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/lang"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/drf"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/hahn"))
                                                                         "cmem")
                                                                    (rec (\,(pre "src/while"))
                                                                         "cmem")))))
                                      (coq-prog-args "-emacs-U")
                                      (eval flet
                                            ((pre (s)
                                                  (concat (locate-dominating-file buffer-file-name ".dir-locals.el")
                                                          s)))
                                            (setq coq-load-path (\`((rec (\,(pre "."))
                                                                         "compcert")))))
                                      (checkdoc-minor-mode . t)
                                      (require-final-newline . t)
                                      (mangle-whitespace . t))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coq-cheat-face ((t (:background "red"))))
 '(coq-solve-tactics-face ((t (:foreground "#d2cb0e"))))
 '(proof-eager-annotation-face ((t (:background "black"))))
 '(proof-error-face ((t (:background "#011225"))))
 '(proof-highlight-dependency-face ((t (:background "black"))))
 '(proof-highlight-dependent-face ((t (:background "black"))))
 '(proof-locked-face ((t (:background "#111111"))))
 '(proof-queue-face ((t (:background "#222222")))))

;; Package
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-list '(paradox hc-zenburn-theme exec-path-from-shell
                             auctex iy-go-to-char yasnippet angular-snippets
                             el-autoyas magit tuareg scala-mode coffee-mode
                             haskell-mode markdown-mode rust-mode cargo
                             paredit flycheck flycheck-color-mode-line
                             flycheck-ocaml flycheck-haskell flycheck-rust
                             proof-general company-coq undo-tree srefactor))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Column
(setq-default fill-column 100)

;; Desktop
(desktop-save-mode t)

;; Yasnippet
(setq-default yas/root-directory '("~/.emacs.d/yasnippet-snippets"))
(yas-global-mode t)

;; Buffers
(global-auto-revert-mode t)
(global-hl-line-mode 1) ; 현재 커서 줄 배경색 바뀜
(setq-default cursor-type 'bar) ; 커서 가는 줄 모드
(setq-default global-auto-revert-non-file-buffers
              t)
(global-set-key [(ctrl tab)]
                'select-next-window)
(global-set-key [(ctrl shift tab)]
                'select-previous-window)
(global-set-key "\C-x\C-k" 'kill-this-buffer)
(global-set-key "\C-x\C-n" 'next-buffer)
(global-set-key "\C-x\C-p" 'previous-buffer)
(global-set-key "\C-x\C-b" 'ibuffer)
(add-hook 'before-save-hook 'delete-trailing-whitespace) ; 저장할 때 트레일링 스페이스 제거

(defun select-next-window ()
  (interactive)
  (select-window (next-window (selected-window))))

(defun select-previous-window ()
  (interactive)
  (select-window (previous-window (selected-window))))

;; Auto-save
(setq-default auto-save-default nil)
(setq-default auto-save-list-file-name nil)
(setq-default make-backup-files nil)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;; (eval-after-load 'flycheck
;;   '(progn
;;      (require 'flycheck-google-cpplint)
;;      ;; Add Google C++ Style checker.
;;      ;; In default, syntax checked by Clang and Cppcheck.
;;      (flycheck-add-next-checker 'c/c++-clang
;;                                 'c/c++-googlelint)))

;; Language
(set-language-environment 'UTF-8)
(set-language-environment-input-method "Korean")
(set-input-method 'korean-hangul)
(toggle-input-method)

;; Key binding
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-c\C-q" 'comment-or-uncomment-region)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-z" 'eshell)
(global-set-key [(ctrl return)]
                'ff-find-other-file)

;; Theme
(load-theme 'hc-zenburn t)
(add-to-list 'default-frame-alist
             '(height . 42))
(add-to-list 'default-frame-alist
             '(width . 140))
(add-to-list 'default-frame-alist
             '(font . "Hack 14"))
(set-face-attribute 'default t :font "Hack 14")
(global-font-lock-mode t)
(setq-default initial-scratch-message "")
(setq-default inhibit-startup-screen t)
(setq-default search-highlight t)
(setq-default query-replace-highlight t)

;; Syntax
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq-default auto-fill-mode t)

;; Magit
(global-set-key (kbd "C-x g")
                'magit-status)

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/")

;; Shell
(add-to-list 'auto-mode-alist
             '(".*.csh\\'" . shell-script-mode))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; ProofGeneral
(add-hook 'coq-mode-hook #'company-coq-mode)

;; Rust
(add-hook 'rust-mode-hook #'cargo-minor-mode)

;; Coq
(setq-default proof-three-window-enable t)
(setq-default proof-shell-process-connection-type
              nil)
(add-to-list 'auto-mode-alist
             '(".*.v\\'" . coq-mode))

;; C
(setq c-default-style "linux")

;; TeX
(if (eq system-type 'darwin)
    (progn
      (require 'tex-site)
                                        ; (load "preview-latex.el" nil t t)
      (add-hook 'TeX-mode-hook
                '(lambda ()
                   (define-key TeX-mode-map "\C-c\C-z" 'TeX-home-buffer)))
      (require 'reftex)
      (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
      (setq-default LaTeX-command "latex -shell-escape")
      (setq-default TeX-PDF-mode t)
      (setq-default TeX-command-list (quote (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t"
                                              TeX-run-TeX
                                              nil
                                              (plain-tex-mode texinfo-mode ams-tex-mode)
                                              :help "Run plain TeX")
                                             ("LaTeX" "%`%l%(mode)%' %t"
                                              TeX-run-TeX
                                              nil
                                              (latex-mode doctex-mode)
                                              :help "Run LaTeX")
                                             ("Makeinfo" "makeinfo %t"
                                              TeX-run-compile
                                              nil
                                              (texinfo-mode)
                                              :help "Run Makeinfo with Info output")
                                             ("Makeinfo HTML" "makeinfo --html %t"
                                              TeX-run-compile
                                              nil
                                              (texinfo-mode)
                                              :help "Run Makeinfo with HTML output")
                                             ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t"
                                              TeX-run-TeX
                                              nil
                                              (ams-tex-mode)
                                              :help "Run AMSTeX")
                                             ("ConTeXt" "texexec --once --texutil %(execopts)%t"
                                              TeX-run-TeX
                                              nil
                                              (context-mode)
                                              :help "Run ConTeXt once")
                                             ("ConTeXt Full" "texexec %(execopts)%t"
                                              TeX-run-TeX
                                              nil
                                              (context-mode)
                                              :help "Run ConTeXt until completion")
                                             ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t
                                              :help "Run BibTeX")
                                             ("View" "%V" TeX-run-discard-or-function t
                                              t :help "Run Viewer")
                                             ("Print" "%p" TeX-run-command t t :help "Print the file")
                                             ("Queue" "%q" TeX-run-background nil t :help "View the printer queue"
                                              :visible TeX-queue-command)
                                             ("File" "%(o?)dvips %d -o %f " TeX-run-command
                                              t t :help "Generate PostScript file")
                                             ("Index" "makeindex %s" TeX-run-command nil
                                              t :help "Create index file")
                                             ("Check" "lacheck %s"
                                              TeX-run-compile
                                              nil
                                              (latex-mode)
                                              :help "Check LaTeX file for correctness")
                                             ("Spell" "(TeX-ispell-document \"\")" TeX-run-function
                                              nil t :help "Spell-check the document")
                                             ("Clean" "TeX-clean" TeX-run-function nil
                                              t :help "Delete generated intermediate files")
                                             ("Clean All" "(TeX-clean t)" TeX-run-function
                                              nil t :help "Delete generated intermediate and output files")
                                             ("Other" "" TeX-run-command t t :help "Run an arbitrary command")
                                             ("XeLaTeX" "xelatex %t"
                                              TeX-run-command
                                              nil
                                              (latex-mode)
                                              :help "Run XeLaTeX"))))))

;; Racket
(add-to-list 'auto-mode-alist
             '(".*.rkt\\'" . scheme-mode))
(add-hook 'scheme-mode-hook
          (lambda ()
            (paredit-mode t)))

;; Mac
(if (eq system-type 'darwin)
    (progn
      (setq-default mac-option-key-is-meta nil)
      (setq-default mac-command-key-is-meta t)
      (setq-default mac-command-modifier 'meta)
      (setq-default mac-option-modifier 'none)
      (setq-default TeX-view-program-list (quote (("Skim"
                                                   ("open %o")))))
      (setq-default TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv")
                                                       (output-dvi "xdvi")
                                                       (output-pdf "Skim")
                                                       (output-html "xdg-open"))))
      ;; Path
      (setq-default explicit-shell-file-name "/bin/zsh")
      (exec-path-from-shell-initialize)))

;; Ispell
(setq-default ispell-program-name "aspell")
(ispell-change-dictionary "english")

(setq ring-bell-function 'ignore)

;; PATH
(setenv "PATH"
        (concat (getenv "HOME")
                "/.local/bin"
                ";"
                (getenv "PATH")))

;; uniquify
(defun uniq-lines (beg end)
  "Unique lines in region. Called from a program, there are two arguments: BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction (narrow-to-region beg end)
                      (goto-char (point-min))
                      (while (not (eobp))
                        (kill-line 1)
                        (yank)
                        (let ((next-line (point)))
                          (while (re-search-forward (format "^%s"
                                                            (regexp-quote (car kill-ring)))
                                                    nil
                                                    t)
                            (replace-match "" nil nil))
                          (goto-char next-line))))))

;; JavaScript
(setq js-indent-level 4)

;; Ispell for Dired
(defun dired-do-ispell (&optional arg)
  (interactive "P")
  (dolist (file (dired-get-marked-files nil
                                        arg
                                        #'(lambda (f)
                                            (not (file-directory-p f)))))
    (save-window-excursion (with-current-buffer (find-file file)
                             (ispell-buffer)))
    (message nil)))

;; gtags
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'c-mode-common-hook
          (lambda ()
            (gtags-mode 1)))
(defun gtags-create-or-update ()
  "create or update the gnu global tag file"
  (interactive)
  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
      (let ((olddir default-directory)
            (topdir (read-directory-name "gtags: top of source tree:"
                                         default-directory)))
        (cd topdir)
        (shell-command "gtags && echo 'created tagfile'")
        (cd olddir)) ; restore
    ;;  tagfile already exists; update it
    (shell-command "global -u && echo 'updated tagfile'")))
(add-hook 'c-mode-common-hook
          (lambda ()
            (gtags-create-or-update)))
(add-hook 'gtags-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.")
                           'gtags-find-tag)
            (local-set-key (kbd "M-,")
                           'gtags-find-rtag)))
(defun gtags-update-single (filename)
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process "update-gtags"
                 "update-gtags"
                 "bash"
                 "-c"
                 (concat "cd "
                         (gtags-root-dir)
                         " ; gtags --single-update "
                         filename)))
(defun gtags-update-current-file ()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir)
                                           "."
                                           (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))
(defun gtags-update-hook ()
  "Update GTAGS file incrementally upon saving a file"
  (when gtags-mode
    (when (gtags-root-dir)
      (gtags-update-current-file))))
(add-hook 'after-save-hook 'gtags-update-hook)

;; Lisp
(require 'srefactor)
(require 'srefactor-lisp)
;; OPTIONAL: ADD IT ONLY IF YOU USE C/C++.
(semantic-mode 1) ;; -> this is optional for Lisp
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(global-set-key (kbd "M-RET o")
                'srefactor-lisp-one-line)
(global-set-key (kbd "M-RET m")
                'srefactor-lisp-format-sexp)
(global-set-key (kbd "M-RET d")
                'srefactor-lisp-format-defun)
(global-set-key (kbd "M-RET b")
                'srefactor-lisp-format-buffer)


(provide 'init)

;;; init.el ends here
