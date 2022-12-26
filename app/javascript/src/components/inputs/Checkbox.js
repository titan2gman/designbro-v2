import pick from 'lodash/pick'

import React from 'react'
import PropTypes from 'prop-types'
import { Errors, Field } from 'react-redux-form'
import { ErrorWrapper, showError } from '../inputs/MaterialInput'
import classNames from 'classnames'

const Checkbox = (props) => {
  const inputOptions = pick(props, [
    'onChange', 'disabled', 'id'
  ])

  const { model, updateOn, label, validators, errors, className } = props

  return (
    <Field model={model} validators={validators} updateOn={updateOn} >
      {(fv) => {
        const showErrors = showError(fv, props.showErrors)
    
        return (
          <div className={classNames(className, { 'is-focused': !!fv.value, 'is-invalid': showErrors })}>
            <label className="settings__checkbox-item main-checkbox">
              <input className="main-checkbox__input" type="checkbox" {...inputOptions} />
  
              <span className="settings__checkbox-item-icon main-checkbox__icon" />
  
              <span className="settings__checkbox-item-text main-checkbox__text">
                {label}
              </span>
            </label>
            
            {showErrors &&
            <Errors model={model} messages={errors} wrapper={ErrorWrapper} component="div" />
            }
          </div>
        )
      }}
    </Field>
  )
}

Checkbox.propTypes = {
  label: PropTypes.string.isRequired,
  onChange: PropTypes.func
}

Checkbox.defaultProps = {
  updateOn: 'change'
}

export default Checkbox
