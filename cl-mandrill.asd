;;;; cl-mandrill.asd

(asdf:defsystem #:cl-mandrill
  :serial t
  :description "Common Lisp Client for Mandrill API"
  :author "jsmpereira@gmail.com"
  :license "Specify license here"
  :depends-on (#:drakma
	       #:cl-json)
  :components ((:file "package")
               (:file "cl-mandrill")))

