import React from 'react'

const ErrorMessage = ({ error }) => {
  return !!error && (
    <div className="in-pink-500 error">
      We encountered an error when processing your credit card.
      We were able to successfully verify your card, but our payment provider gave an error when <strong>charging</strong> your card.
      This is the error we received: <strong>{error}</strong>&nbsp;
      Please contact your card issuer via the contact details on the back of your credit card before trying to pay again.
    </div>
  )
}

export default ErrorMessage
