import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import Textarea from 'react-textarea-autosize'
import Label from '../Label'
import Hint from '../Hint'
import ErrorWrapper from '../Error'

const TextareaComponent = ({
  value,
  type,
  autoComplete,
  maxRows,
  maxLength,
  disabled,
  label,
  hint,
  error,
  className,
  wrapped,
  children,
  onChange,
  onBlur
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
        <Textarea
          className="main-input__input"
          autoComplete={autoComplete}
          maxRows={maxRows}
          maxLength={maxLength}
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

TextareaComponent.propTypes = {
  value: PropTypes.string,
  autoComplete: PropTypes.string,
  disabled: PropTypes.bool,
  label: PropTypes.string.isRequired,
  hint: PropTypes.string,
  error: PropTypes.string,
  className: PropTypes.string,
  onChange: PropTypes.func.isRequired,
  onBlur: PropTypes.func
}

export default TextareaComponent
