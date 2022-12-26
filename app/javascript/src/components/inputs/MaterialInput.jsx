import pick from 'lodash/pick'
import isEmpty from 'lodash/isEmpty'

import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { Field, Errors } from 'react-redux-form'

export const showError = (fv, showErrors = true) => showErrors && !fv.focus && !fv.retouched && fv.submitFailed && !isEmpty(fv.errors)

const HintWrapper = ({ text }) => (
  <div className="main-input__hint is-visible in-black">
    {text}
  </div>
)

export const ErrorWrapper = ({ children }) => (
  <div className="main-input__hint in-pink-500">
    {children[0]}
  </div>
)

const MaterialInput = (props) => {
  const inputOptions = pick(props, ['type', 'id', 'name', 'value', 'autoComplete', 'onChange', 'onBlur', 'disabled'])
  const { model, validators, updateOn, label, parser, className, disableAutocomplete } = props

  const disableReadonly = (e) => (
    e.target.removeAttribute('readonly')
  )

  return (
    <Field model={model} validators={validators} updateOn={updateOn} parser={parser}>
      {(fv) => {
        const showErrors = showError(fv, props.showErrors)

        return (
          <div className={classNames('main-input', className, { 'is-focused': !!fv.value, 'is-invalid': showErrors })}>
            <div className="main-input__input-box">
              <input onFocus={disableAutocomplete && disableReadonly} readOnly={disableAutocomplete} className="main-input__input" {...inputOptions} />
              <label className="main-input__label" htmlFor={inputOptions.id}>{label}</label>
            </div>
            {showErrors &&
            <Errors model={model} messages={props.errors} wrapper={ErrorWrapper} component="div" />
            }

            {fv.focus && props.hint && <HintWrapper text={props.hint} />}

            {props.children}
          </div>
        )
      }}
    </Field>
  )
}

MaterialInput.propTypes = {
  hint: PropTypes.string,
  parser: PropTypes.func,
  extra: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func,
  showErrors: PropTypes.bool,
  autoComplete: PropTypes.string,
  id: PropTypes.string.isRequired,
  type: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired
}

export default MaterialInput
