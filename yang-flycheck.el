;;; yang-flycheck.el --- YANG flycheck checker
;; Copyright (c) 2016 Andrew Fort

;; Author: Andrew Fort (@andaru)
;; Version: 0.0
;; Package-Requires: ((yang-mode "0") (flycheck "0.18"))

;;; Commentary:
;; This package configures provides YANG syntax checking via flycheck
;; in emacs using the pyang YANG parser[1].
;;
;; [1] https://github.com/mbj4668/pyang

;;; Code:

(require 'flycheck)

(defgroup yang-pyang nil
  "Support for Flycheck in YANG via pyang"
  :group 'yang)

(defcustom yang-pyang-verbose nil
  "Enable verbose output from pyang."
  :type 'boolean
  :group 'yang-pyang)

(flycheck-define-checker yang-pyang
                         "A YANG syntax checker using the pyang parser."
                         :command ("pyang" "-e"
				   (option-flag "-V" yang-pyang-verbose)
				   source)
                         :error-patterns ((error line-start (file-name) ":"
                                                 line ": " (message) line-end))
                         :modes yang-mode
			 :error-filter
			 (lambda (errors)
			   (-> errors
			       flycheck-dedent-error-messages
			       flycheck-sanitize-errors)))

(add-to-list 'flycheck-checkers 'yang-pyang)

(provide 'yang-flycheck)

;;; yang-flycheck.el ends here
