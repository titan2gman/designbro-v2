import React from 'react'
import { Form } from 'react-redux-form'
import { withRouter } from 'react-router-dom'

import Errors from '../inputs/Errors'
import SubmitButton from '../SubmitButton'
import MaterialInput from '../inputs/MaterialInput'
import PasswordField from '../inputs/PasswordField'
import TermsModal from '../modals/TermsModal'
import PrivacyPolicyModal from '../modals/PrivacyPolicyModal'
import Checkbox from '../inputs/Checkbox'

import { isEmail, required, isWeak, allowedDisplayName } from '@utils/validators'

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

const SignupEmailDesignerForm = ({ history, onSubmit, onSuccess, onError }) => {
  const callback = () => {
    history.push('/d/signup/profile')
  }

  return (
    <Form model="forms.signup" onSubmit={(v) => onSubmit(v).then((fsa) => fsa.error ? onError(fsa) : onSuccess(fsa, callback))}>
      <Errors model="." />

      <fieldset>
        {/* DON'T delete this line! It's solution for disabling inputs' auto complete */}
        <input type="password" style={{ visibility: 'hidden', float: 'left' }} />

        <MaterialInput
          type="text"
          id="displayName"
          name="displayName"
          autoComplete="nope"
          model=".displayName"
          validators={{ required, allowedDisplayName }}
          label="Displayed username"
          errors={{ required: 'Please enter your user name', allowedDisplayName: '"." and "@" are not allowed' }} />

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
      
      <Checkbox
        id="agreement"
        model=".agreement"
        validators={{ required }}
        className="main-input"
        errors={{ required: 'Required' }}
        label="Allow DesignBro to send you emails relating to the functioning of the platform as well as marketing"/>
        
      <SubmitButton
        icon="icon-arrow-right"
        text="Join as a Designer"
        colorClass="main-button--black-pink"
      />
    </Form>
  )
}

export default withRouter(SignupEmailDesignerForm)
