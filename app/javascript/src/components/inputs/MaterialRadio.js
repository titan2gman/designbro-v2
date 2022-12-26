import pick from 'lodash/pick'
import isEmpty from 'lodash/isEmpty'

import React from 'react'
import PropTypes from 'prop-types'
import { Field, Errors } from 'react-redux-form'

const showError = (fv) => !fv.focus && !fv.retouched && fv.submitFailed && !isEmpty(fv.errors)

const ErrorWrapper = ({ children }) => <div className="main-input__hint in-pink-500">{children}</div>

const MaterialRadio = (props) => {
  const inputOptions = pick(props, ['name', 'value', 'autoComplete', 'onChange', 'disabled'])

  return (
    <Field model={props.model} validators={props.validators} updateOn={props.updateOn} className={props.className}>
      {(fv) =>
        (<div>
          <label className="main-radio m-b-0" id={props.id}>
            <input className="main-radio__input" type="radio" {...inputOptions} />
            <span className="main-radio__icon m-r-10" />
            <span className="main-radio__text">{props.label}</span>
          </label>

          {props.children}

          {showError(fv) && <Errors model={props.model} messages={props.errors} wrapper={ErrorWrapper} component="div" />}
        </div>)
      }
    </Field>
  )
}

MaterialRadio.propTypes = {
  id: PropTypes.string,
  name: PropTypes.string,
  extra: PropTypes.string,
  error: PropTypes.string,
  onChange: PropTypes.func,
  updateOn: PropTypes.string,
  autoComplete: PropTypes.string,
  model: PropTypes.string.isRequired,
  label: PropTypes.oneOfType([
    PropTypes.string.isRequired,
    PropTypes.object.isRequired
  ])
}

export default MaterialRadio
