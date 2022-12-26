import React, { Component } from 'react'
import PropTypes from 'prop-types'

import { Link } from 'react-router-dom'
import { Form } from 'react-redux-form'

import { persistHeaders, getRedirectPath } from '@utils/auth'

import Errors from '@components/inputs/Errors'
import SubmitButton from '@components/SubmitButton'
import MaterialInput from '@components/inputs/MaterialInput'

class LoginForm extends Component {
  handleSubmit = (v) => {
    const handleSuccess = (fsa) => {
      persistHeaders(fsa.meta)

      const data = fsa.payload.data

      this.props.hideAuthForm()

      const redirectPath = getRedirectPath(data)

      if (redirectPath) {
        this.props.history.push(redirectPath)
      }
    }

    this.props.signinEmail(v).then((fsa) => fsa.error ? this.props.onError(fsa) : handleSuccess(fsa))
  }

  render () {
    return (
      <Form
        model="forms.signin"
        autoComplete="false"
        onSubmit={this.handleSubmit}
      >
        <Errors model="." />

        <fieldset className="m-b-15">
          {/* DON'T delete this line! It's solution for disabling inputs' auto complete */}
          <input type="password" style={{ visibility: 'hidden', float: 'left' }} />

          <MaterialInput
            id="email"
            type="email"
            name="email"
            label="Email"
            model=".email"
            autoComplete="nope" />

          <MaterialInput
            id="password"
            type="password"
            name="password"
            label="Password"
            model=".password"
            autoComplete="nope" />

          <div className="text-left">
            <Link to="/restore-password" className="sign-in__form-text text-underline">
              Forgot password?
            </Link>
          </div>
        </fieldset>

        <SubmitButton text="Log in" colorClass="main-button--pink-black" icon="icon-arrow-right" />
      </Form>
    )
  }
}

LoginForm.propTypes = {
  onSubmit: PropTypes.func.isRequired,
  onSuccess: PropTypes.func.isRequired,
  onError: PropTypes.func.isRequired
}

export default LoginForm
