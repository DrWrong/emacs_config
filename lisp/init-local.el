;;; package --- Summary
;;; Code:
;;; Commentary:
(defun rsyncdev ()
  "Auto rsyncdev."
  (interactive)
  ( start-process-shell-command
    "rsync-to-dev"
    nil
    "rsyncdev 207"))

(defun sync-domob-file ()
  "Sync domob file auto."
  (when (string-match
         "/Users/drwrong/mywork/domob/.*"
         buffer-file-name)
    (rsyncdev))
  )

(define-minor-mode auto-rsync-mode
  :lighter "rsync"
  :global t
  (cond (auto-rsync-mode
         (add-hook 'after-save-hook 'sync-domob-file))
        (t
         (remove-hook 'after-save-hook 'sync-domob-file))))

(auto-rsync-mode t)

;; add some hooksy
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'pytonn-mode-hook (lambda () (ggtags-mode 1)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'python-mode)
              (ggtags-mode 1))))

;; go-mode-hook
(setq gofmt-command "goimports")
(add-hook 'go-mode-hook
          (lambda ()
            (go-set-project)
            (add-hook 'before-save-hook 'gofmt-before-save)
            )
          )

;; (require 'emmet-mode)
(setq emmet-expand-jsx-className? t)

(add-hook 'web-mode-hook 'emmet-mode)
;; config
(setq-local hippie-expand-try-functions-list
            (cons 'ggtags-try-complete-tag hippie-expand-try-functions-list))



(osx-clipboard-mode t)


;; customize elpa
(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
                         ("org" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                           ("~/gtd/someday.org" :level . 1)
                           ("~/gtd/tickler.org" :maxlevel . 2))
      )
(setq org-refile-use-outline-path 'file)
(add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
(add-hook 'js2-mode-hook 'eslintd-fix-mode)
;; go company
(require 'company-go)
(provide 'init-local)
;;; init-local.el ends here
