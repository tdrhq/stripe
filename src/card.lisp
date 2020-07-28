(in-package #:net.mfiano.lisp.stripe)

(define-object card ()
  id
  address
  available-payment-methods
  brand
  country
  customer
  exp-month
  exp-year
  fingerprint
  funding
  last4
  name
  tokenization-method)

(defmethod initialize-instance :after ((instance card) &key data
                                       &allow-other-keys)
  (reinitialize-instance
   instance
   :address (apply #'make-instance 'address data)))

(define-query create-card (:type card)
  (:post "customers/~a/sources" customer)
  source)

(define-query retrieve-card (:type card)
  (:get "customers/~a/sources/~a" customer card))

(define-query update-card (:type card)
  (:post "customers/~a/sources/~a" customer card)
  address-city
  address-country
  address-line1
  address-line2
  address-state
  address-zip
  exp-month
  exp-year
  name)

(define-query delete-card ()
  (:delete "customers/~a/sources/~a" customer card))

(define-query list-cards (:type list)
  (:get "customers/~a/sources?object=card" customer))
