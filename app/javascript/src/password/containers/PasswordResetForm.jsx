import React, { Component } from 'react'
import { connect } from 'react-redux'
import { history } from '../../history'

import { open } from '@actions/simpleModal'
import showServerErrors from '@utils/errors'
import { validateResetToken, resetPassword } from '@actions/auth'
import partial from 'lodash/partial'

import PasswordChangeForm from '@password/components/PasswordChangeForm'

class Container extends Component {
  componentWillMount () {
    this.props.validateResetToken(this.props.token).then(
      (fsa) => { if (fsa.error) history.push('/') }
    )
  }

  render () {
    const { onSubmit, token, ...props } = this.props
    const submit = partial(onSubmit, token)
    return <PasswordChangeForm {...props} onSubmit={submit} />
  }
}

const onSubmit = resetPassword
const onSuccess = () => {
  return [
    history.push('/login'),
    open({ title: 'Success', message: 'Password was successfully reset!' })
  ]
}

const onError = showServerErrors('forms.changePassword', {
  404: () => history.push('/')
})

const mapStateToProps = (_, ownProps) => ({
  requireCurrentPassword: false,
  token: ownProps.token
})

export default connect(mapStateToProps, {
  onSubmit, onSuccess, onError, validateResetToken
})(Container)
