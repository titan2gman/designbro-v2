import pick from 'lodash/pick'
import isEmpty from 'lodash/isEmpty'

import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import Textarea from 'react-textarea-autosize'
import { Field, Control, Errors } from 'react-redux-form'

const showError = (fv, showErrors = true) => showErrors && !fv.focus && !fv.retouched && fv.submitFailed && !isEmpty(fv.errors)

const HintWrapper = ({ text }) => (
  <div className="main-input__hint is-visible in-black">
    {text}
  </div>
)

const ErrorWrapper = ({ children }) => (
  <div className="main-input__hint in-pink-500">
    {children}
  </div>
)

const MaterialTextarea = (props) => {
  const inputOptions = pick(props, ['type', 'name', 'value', 'autoComplete', 'onChange', 'onBlur', 'disabled', 'validators', 'maxLength', 'id'])
  const { label, className, showErrors, hint, maxRows } = props

  return (
    <Field model={props.model} validators={props.validators}>
      {(fv) => (
        <div className={classNames('main-input', className, { 'is-focused': !!fv.value, 'is-invalid': showError(fv, showErrors) })}>
          <div className="main-input__input-box">
            <Control.textarea
              {...inputOptions}
              maxRows={maxRows}
              model={props.model}
              component={Textarea}
              className="main-input__textarea"
            />

            <label className="main-input__label" htmlFor={props.id}>{label}</label>
          </div>

          {fv.focus && hint && <HintWrapper text={hint} />}

          {showError(fv, showErrors) && <Errors model={props.model} messages={props.errors} wrapper={ErrorWrapper} component="div" />}

          {props.children}
        </div>
      )}
    </Field>
  )
}

MaterialTextarea.propTypes = {
  type: PropTypes.string.isRequired,
  id: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  extra: PropTypes.string,
  autoComplete: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func
}

export default MaterialTextarea
