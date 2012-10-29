;;;; cl-mandrill.lisp

(in-package #:cl-mandrill)

;;; TODO: implement API properly!

(defparameter *api-root* "https://mandrillapp.com/api/1.0/")

;; Messaging API
(defparameter *send* "messages/send.json")

(defvar *api-key* nil)

(defun set-key (key)
  (setf *api-key* key))

(defun simple-message-send (&rest rest)
  (let ((endpoint (concatenate 'string *api-root* *send*)))
    (drakma:http-request endpoint
			 :method :post
			 :content-type "application/json"
			 :content (apply #'simple-message rest))))

(defun simple-message (&key from to subject message attachments)
  "Build simple message. Basic fields. Multiple attachments supported."
  (json:with-explicit-encoder
    (json:encode-json-to-string
     `(:plist :key ,*api-key*
	      :message (:plist :html ,message
			       :subject ,subject
			       :from--email ,from
			       :to (:list (:plist :email ,to))
			       :attachments (:list ,@(build-attachments attachments)))))))

(defun build-attachments (attachments)
  (loop for element in attachments
       for path = (getf element :path)
       for type = (getf element :type)
       for name = (getf element :name)
     collect (encode-attachment path type name)))
			      				
(defun encode-attachment (path type name)
  (with-open-file (s path :element-type '(unsigned-byte 8))
    (let ((buf (make-array (file-length s) :element-type '(unsigned-byte 8) :adjustable t)))
      (read-sequence buf s)
      `(:plist :type ,type :name ,name :content ,(cl-base64:usb8-array-to-base64-string buf)))))
  
		    
