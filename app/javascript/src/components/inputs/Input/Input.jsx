import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import Label from '../Label'
import Hint from '../Hint'
import ErrorWrapper from '../Error'

const Input = ({
  name,
  value,
  type,
  autoComplete,
  disabled,
  label,
  hint,
  error,
  className,
  children,
  onChange,
  onBlur,
}) => {
  const [focused, setFocused] = useState(false)

  const handleFocus = () => { setFocused(true) }

  const handleBlur = () => {
    setFocused(false)
    onBlur && onBlur()
  }

  return (
    <div
      className={classNames('main-input', className, {
        'is-focused': !!value,
        'is-invalid': !!error
      })}
    >
      <div className="main-input__input-box">
        <input
          className="main-input__input"
          type={type}
          name={name}
          autoComplete={autoComplete}
          disabled={disabled}
          value={value || ''}
          onChange={onChange}
          onFocus={handleFocus}
          onBlur={handleBlur}
        />

        <Label>{label}</Label>
      </div>

      {error && <ErrorWrapper>{error}</ErrorWrapper>}

      {focused && <Hint>{hint}</Hint>}

      {children}
    </div>
  )
}

Input.propTypes = {
  value: PropTypes.string,
  type: PropTypes.string.isRequired,
  autoComplete: PropTypes.string,
  disabled: PropTypes.bool,
  label: PropTypes.string.isRequired,
  hint: PropTypes.string,
  className: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func.isRequired,
  onBlur: PropTypes.func
}

Input.defaultProps = {
  type: 'text',
}

export default Input
