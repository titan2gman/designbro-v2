import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'

import { required, isEmail, isWeak } from '@utils/validators'

import Errors from '@components/inputs/Errors'
import MaterialInput from '@components/inputs/MaterialInput'
import PasswordField from '@components/inputs/PasswordField'

const ClientSignUpForm = ({ onFormInputBlur }) => (
  <Form model="forms.signup" autoСomplete="off">
    <Errors model="." />

    <fieldset>
      {/* DON'T delete this line! It's solution for disabling inputs' auto complete */}
      <input type="password" style={{ visibility: 'hidden', float: 'left' }} />

      <span id="email__container">
        <MaterialInput
          id="email"
          type="text"
          name="email"
          label="Email"
          model=".email"
          autoComplete="off"
          disableAutocomplete={true}
          onBlur={onFormInputBlur}
          validators={{ required, isEmail }}
          errors={{ required: 'Required.', isEmail: 'Please enter a valid email address' }} />
      </span>

      <span id="password__container">
        <PasswordField
          id="password"
          type="password"
          name="password"
          model=".password"
          autoComplete="off"
          disableAutocomplete={true}
          onBlur={onFormInputBlur}
          label="Create your password"
          validators={{ required, isWeak }}
          errors={{ required: 'Required.', isWeak: 'Password is too weak. Please use stronger one' }} />
      </span>
    </fieldset>
  </Form>
)

ClientSignUpForm.propTypes = {
  onFormInputBlur: PropTypes.func.isRequired
}

export default ClientSignUpForm
