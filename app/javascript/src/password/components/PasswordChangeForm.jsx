import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'

import Errors from '@components/inputs/Errors'
import SubmitButton from '@components/SubmitButton'
import MaterialInput from '@components/inputs/MaterialInput'
import PasswordField from '@components/inputs/PasswordField'

import { required, passwordLengthValidator } from '@utils/validators'

const CurrentPasswordInput = () => (
  <MaterialInput
    id="password"
    type="password"
    name="currentPassword"
    validators={{ required }}
    model=".currentPassword"
    autoComplete="new-password"
    label="Enter current password"
    errors={{ required: 'Required' }} />
)

const PasswordChangeForm = ({ onSubmit, onSuccess, onError, requireCurrentPassword }) => (
  <Form model="forms.changePassword" onSubmit={(v) => onSubmit(v).then((fsa) => fsa.error ? onError(fsa) : onSuccess(fsa))}>
    <Errors model="." />

    <input type="password" style={{ display: 'none' }} />

    {requireCurrentPassword && <CurrentPasswordInput />}

    <PasswordField
      id="password"
      type="password"
      name="password"
      model=".password"
      className="m-b-40"
      label="Enter new password"
      autoComplete="new-password"
      validators={{ minLength: passwordLengthValidator, required }}
      errors={{ minLength: 'Your password must be at least 6 characters long', required: 'Required' }}
    />

    <SubmitButton colorClass="main-button--pink-black" text="Set Password" />
  </Form>
)

PasswordChangeForm.propTypes = {
  onError: PropTypes.func,
  onSubmit: PropTypes.func.isRequired,
  onSuccess: PropTypes.func.isRequired,
  requireCurrentPassword: PropTypes.bool
}

PasswordChangeForm.defaultProps = {
  requireCurrentPassword: true
}

export default PasswordChangeForm
