Common Lisp Client for Mandrill API (in time).

Signup at https://mandrill.com/

Usage:
(set-key "your-api-key")

(simple-message-send :from "jonh@example.com"
		     :to "mary@exampe.com"
		     :subject "Hello world."
		     :message "Just saying hi."
		     :attachments '((:path "path-to-file"
		     		     :type "file-type"
				     :name "filename")
				    (:path "path-to-other-file"
				     :type "file-type"
				     :name "filename")))


TODO

- properly implement API
