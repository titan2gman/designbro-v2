export const allowToVisitSuccessfulPaymentPage = () => ({
  type: 'ALLOW_TO_VISIT_SUCCESSFUL_PAYMENT_PAGE'
})

export const disallowToVisitSuccessfulPaymentPage = () => ({
  type: 'DISALLOW_TO_VISIT_SUCCESSFUL_PAYMENT_PAGE'
})

export const disallowToContinueWithPayPal = () => ({
  type: 'DISALLOW_TO_CONTINUE_WITH_PAY_PAL'
})

export const setPaypalLoaded = () => ({
  type: 'PAYPAL_LOADED'
})
