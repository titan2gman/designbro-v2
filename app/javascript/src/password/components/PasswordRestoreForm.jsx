import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'

import Errors from '@components/inputs/Errors'
import SubmitButton from '@components/SubmitButton'
import MaterialInput from '@components/inputs/MaterialInput'

import { required, isEmail } from '@utils/validators'

const PasswordRestoreForm = ({ onSubmit, onSuccess, onError }) =>
  (<Form className="col-md-6 col-lg-5" model="forms.restorePassword"
    onSubmit={(v) => onSubmit(v).then((fsa) => fsa.error ? onError(fsa) : onSuccess(fsa))}>

    <Hint />
    <Errors model="." />

    <MaterialInput
      id="email"
      type="text"
      name="email"
      label="Email"
      model=".email"
      className="m-b-40"
      autoComplete="email"
      validators={{ required, isEmail }}
      parser={(string) => string.trim()}
      errors={{ required: 'Required', isEmail: 'It doesn\'t look like email' }}
    />

    <SubmitButton colorClass="main-button--pink-black" text="Restore" />
  </Form>)

const Hint = () => (
  <div className="main-hint in-grey-400">
    <i className="main-hint__icon icon-info-circle" />

    <p className="main-hint__text in-grey-200">
      Please enter the e-mail you’ve used to register
      and we’ll send you a link to reset your password.
    </p>
  </div>
)

PasswordRestoreForm.propTypes = {
  onSubmit: PropTypes.func.isRequired,
  onSuccess: PropTypes.func.isRequired,
  onError: PropTypes.func
}

export default PasswordRestoreForm
