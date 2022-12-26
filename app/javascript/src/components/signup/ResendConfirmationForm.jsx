import React from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'
import { history } from '../../history'

import { required, isEmail } from '@utils/validators'

import MaterialInput from '../inputs/MaterialInput'

const SubmitButton = () => (
  <button className="main-button main-button--lg font-16 main-button--pink-black m-b-30" type="submit">
    Send inivitation
    <i className="icon-arrow-right-long align-middle m-l-20 font-8" />
  </button>
)

const ConfirmationEmailResendForm = ({ confirmationResend }) => {
  const onSuccess = () => {
    window.alert(`
      If your email address exists in our database,
      you will receive an email with instructions for
      how to confirm your email address in a few minutes.
    `)

    history.push('/d/signup/confirmation')
  }

  const onError = () => history.push('/errors/500')


  return (
    <Form className="col-lg-6" model="forms.signupConfirmation" onSubmit={(v) => confirmationResend(v).then((fsa) => fsa.error ? onError(fsa) : onSuccess(fsa))}>
      <MaterialInput
        label="Email"
        id="email"
        type="email"
        name="email"
        className="m-b-40"
        model=".email"
        validators={{ required, isEmail }}
        errors={{ required: 'Required', isEmail: 'It doesn\'t look like email' }}
      />

      <SubmitButton />
    </Form>
  )
}

ConfirmationEmailResendForm.propTypes = {
  confirmationResend: PropTypes.func.isRequired,
}

export default ConfirmationEmailResendForm
