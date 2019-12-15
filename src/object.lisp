(in-package #:stripe)

(defmacro define-object (name super-classes &body fields)
  (alexandria:with-gensyms (stream)
    (let ((slots (mapcar
                  (lambda (x)
                    (let ((name (alexandria:ensure-list x)))
                      (destructuring-bind (name
                                           &key (reader name) extra-initargs)
                          name
                        `(,(alexandria:symbolicate '#:% name)
                          :reader ,reader
                          :initarg ,(alexandria:make-keyword name)
                          ,@(when extra-initargs
                              `(,@(mapcan
                                   (lambda (x)
                                     `(:initarg ,x))
                                   extra-initargs)))))))
                  fields)))
      `(progn
         (defclass ,name
             ,@(if super-classes
                   `(,super-classes)
                   `((stripe-object)))
           ,slots)
         (golden-utils:define-printer (,name ,stream :type nil)
           (if (and (slot-exists-p ,name '%id)
                    (slot-boundp ,name '%id))
               (format ,stream "~a ~a" ',name (id ,name))
               (format ,stream "~a" ',name)))))))

(defclass stripe-object () ())

(defmethod initialize-instance :after ((instance stripe-object) &key data
                                       &allow-other-keys)
  (apply #'reinitialize-instance
         instance
         :allow-other-keys t
         data))

(define-object address ()
  (line1 :extra-initargs (:address-line1))
  (line2 :extra-initargs (:address-line2))
  (city :extra-initargs (:address-city))
  (state :extra-initargs (:address-state))
  (postal-code :extra-initargs (:address-zip))
  (country :extra-initargs (:address-country)))

(define-object shipping ()
  address
  name
  phone)

(defmethod initialize-instance :after ((instance shipping) &key data
                                       &allow-other-keys)
  (destructuring-bind (&key address &allow-other-keys) data
    (reinitialize-instance
     instance
     :address (make-instance 'address :data address))))

(define-object billing-details (shipping)
  email)
