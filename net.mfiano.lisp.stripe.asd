(asdf:defsystem #:net.mfiano.lisp.stripe
  :description "A client for the Stripe payment API."
  :author ("Michael Fiano <mail@mfiano.net>")
  :license "MIT"
  :homepage "https://mfiano.net/projects/stripe"
  :source-control (:git "https://github.com/mfiano/stripe")
  :bug-tracker "https://github.com/mfiano/stripe/issues"
  :encoding :utf-8
  :depends-on (#:dexador
               #:local-time
               #:net.mfiano.lisp.golden-utils
               #:yason)
  :pathname "src"
  :serial t
  :components
  ((:file "package")
   (:file "common")
   (:file "error")
   (:file "object")
   (:file "query")
   (:file "balance")
   (:file "balance-transaction")
   (:file "card")
   (:file "charge")
   (:file "coupon")
   (:file "source")
   (:file "credit-note")
   (:file "customer")
   (:file "customer-balance-transaction")
   (:file "customer-tax-id")
   (:file "discount")
   (:file "invoice")
   (:file "invoice-item")
   (:file "order")
   (:file "payout")
   (:file "plan")
   (:file "product")
   (:file "refund")
   (:file "return")
   (:file "sku")
   (:file "subscription")
   (:file "subscription-item")
   (:file "token")))
