(in-package #:net.mfiano.lisp.stripe)

(define-object source ()
  id
  amount
  currency
  customer
  owner
  redirect
  statement-descriptor
  status
  (type :reader source-type))
