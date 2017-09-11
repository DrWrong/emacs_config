;;; local config
(defun rsyncdev ()
  "auto rsyncdev"
  (interactive)
  ( start-process-shell-command
    "rsync-to-dev"
    nil
    "rsync -au --delete --exclude-from=/Users/DrWrong/mywork/domob/.rsync_exclude /Users/DrWrong/mywork/domob chengyuhang@10.0.0.207:"))

(defun sync-domob-file ()
  "sync domob file auto"
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
(add-hook 'before-save-hook 'go-fmt-before-save)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'python-mode)
              (ggtags-mode 1))))



(require 'emmet-mode)
(setq emmet-expand-jsx-className? t)

(add-hook 'web-mode-hook 'emmet-mode)
;; config
(setq-local hippie-expand-try-functions-list
            (cons 'ggtags-try-complete-tag hippie-expand-try-functions-list))



(osx-clipboard-mode t)

(provide 'init-local)
