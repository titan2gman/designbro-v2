import React from 'react'
import { Form } from 'react-redux-form'
import { withRouter } from 'react-router-dom'

import Errors from '../inputs/Errors'
import SubmitButton from '../SubmitButton'
import MaterialInput from '../inputs/MaterialInput'
import PasswordField from '../inputs/PasswordField'
import TermsModal from '../modals/TermsModal'
import PrivacyPolicyModal from '../modals/PrivacyPolicyModal'

import { isEmail, isWeak } from '@utils/validators'

const Terms = () => (
  <p className="sign-in__form-text m-b-30">
    By joining you agree with our
    {' '}
    <TermsModal linkClasses="sign-in__form-link cursor-pointer" />
    {' '}
    and
    {' '}
    <PrivacyPolicyModal linkClasses="sign-in__form-link cursor-pointer" />
  </p>
)

const EmailSignupClientForm = ({ history, onSubmit, onSuccess, onError }) => {
  const callback = () => {
    history.push('/c')
  }

  return (
    <Form model="forms.signup" onSubmit={(v) => onSubmit(v).then((fsa) => fsa.error ? onError(fsa) : onSuccess(fsa, callback))}>
      <Errors model="." />

      <fieldset>
        {/* DON'T delete this line! It's solution for disabling inputs' auto complete */}
        <input type="password" style={{ visibility: 'hidden', float: 'left' }} />

        <MaterialInput
          id="email"
          type="text"
          name="email"
          label="Email"
          model=".email"
          autoComplete="nope"
          validators={{ isEmail }}
          errors={{ isEmail: 'Please enter a valid email address' }} />

        <PasswordField
          id="password"
          type="password"
          name="password"
          label="Password"
          model=".password"
          autoComplete="nope"
          validators={{ isWeak }}
          errors={{ isWeak: 'Password is too weak. Please use stronger one' }} />
      </fieldset>

      <Terms />

      <SubmitButton icon="icon-arrow-right"
        text="Sign up as a Client"
        colorClass="main-button--black-pink" />
    </Form>
  )
}

export default withRouter(EmailSignupClientForm)
