(defpackage #:mailgun/core
  (:use #:cl)
  (:nicknames #:mailgun)
  (:import-from #:log4cl)
  (:import-from #:dexador
                #:post)
  (:import-from #:spinneret
                #:with-html-string
                #:with-html)
  (:import-from #:secret-values
                #:ensure-value-revealed)

  (:export
   #:send
   #:test-send
   #:*domain*
   #:*api-key*
   #:*user-agent*))
(in-package mailgun/core)


(defvar *domain* nil)
(defvar *api-key* nil
  "This can be a string or secret-values:secret-value.")
(defvar *user-agent* "cl-mailgun")


(defun send-html (from email subject html-body)
  (let* ((data `(("from" . ,from)
                 ("to" . ,email)
                 ("subject" . ,subject)
                 ("html" . ,html-body)))
         (headers `(("User-Agent" . ,*user-agent*))))
    
    (unless *domain*
      (error "Unable to send email to ~A because mailgun:*domain* is nil" email))
    (unless *api-key*
      (error "Unable to send email to ~A because mailgun:*api-key* is nil" email))
    
    (post (format nil "https://api.mailgun.net/v3/~A/messages"
                  *domain*)
          :basic-auth (cons "api"
                            (ensure-value-revealed *api-key*))
          :content data
          :headers headers)
    
    (values)))


(defmacro send ((from email subject) &body body)
  "Sends HTML letter to an email.

   Body of this macro should contain a markup for spinneret library.
   Also, it can use \"htm\" macro, to wrap html markup in the inner
   lisp constructions such as loops and conditional expressions."
  `(macrolet ((htm (&body body)
                `(with-html ,@body)))
     (send-html ,from
                ,email
                ,subject
                (with-html-string ,@body))))
