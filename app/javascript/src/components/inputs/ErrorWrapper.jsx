import React from 'react'

const ErrorWrapper = ({ error }) => {
  return error && (
    <div className="main-input__hint in-pink-500">{error}</div>
  )
}

export default ErrorWrapper
