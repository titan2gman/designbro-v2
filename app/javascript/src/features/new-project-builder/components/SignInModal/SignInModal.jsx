import React, { useState } from 'react'
import { useDispatch } from 'react-redux'
import cn from 'classnames'
import { Modal } from 'semantic-ui-react'

import Headline from '../Headline'
import Input from '../Input'
import PasswordInput from '../PasswordInput'
import { ContinueButton } from '../Footer'

import { signinEmail } from '@actions/auth'
import { onSuccess } from '@actions/signup'

import { isEmail, isWeak } from '@utils/validators'

import { showSignUpModal, hideModal } from '@actions/modal'

import styles from './SignInModal.module.scss'

const SignInModal = ({ title, successCallback }) => {
  const dispatch = useDispatch()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  const isValid = email && isEmail(email) && password

  const handleSignUpClick = () => {
    dispatch(hideModal())
    dispatch(showSignUpModal({ successCallback }))
  }

  const handleClose = () => {
    dispatch(hideModal())
  }

  const handleEmailChange = (event) => {
    setEmail(event.target.value)
  }

  const handlePasswordChange = (event) => {
    setPassword(event.target.value)
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    dispatch(signinEmail({ email, password })).then((response) => {
      if (!response.error) {
        dispatch(onSuccess(response, successCallback))
      }
    })
  }

  return (
    <Modal
      size="tiny"
      open
      className={styles.modal}
    >
      <div className={cn('icon-cross', styles.closeIcon)} onClick={handleClose} />

      <Modal.Content className={styles.modalContent}>
        <Headline>{title}</Headline>

        <form onSubmit={handleSubmit}>
          <div className={styles.signUpForm}>
            <Input
              inputClassName={styles.input}
              value={email}
              onChange={handleEmailChange}
              placeholder="Email"
            />

            <PasswordInput
              inputClassName={styles.input}
              type="password"
              value={password}
              onChange={handlePasswordChange}
              placeholder="Password"
            />
          </div>

          <div className={styles.modalFooter}>
            <ContinueButton isValid={isValid} popupContent="Please&nbsp;create&nbsp;your&nbsp;account before&nbsp;checking&nbsp;out">Login →</ContinueButton>

            <p>
              <span className={styles.createNewAccount} onClick={handleSignUpClick}>Create new account</span>
            </p>
          </div>
        </form>
      </Modal.Content>
    </Modal>
  )
}

SignInModal.defaultProps = {
  title: 'Welcome back!'
}

export default SignInModal
