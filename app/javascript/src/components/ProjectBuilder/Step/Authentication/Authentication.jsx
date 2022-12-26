import React from 'react'
import PropTypes from 'prop-types'

import ClientSignUpForm from './ClientSignUpFormContainer'
import ClientSignInModal from './ClientSignInModal'

const TitleWithLogin = () => (
  <div>
    <span className="font-bold in-grey-400">
      Create your account
    </span> (or login <ClientSignInModal />)
  </div>
)

const TitleWithoutLogin = () => (
  <span className="font-bold in-grey-400">
    Create your account
  </span>
)

const Authentication = ({ isAuthFormVisible, authenticated }) => (
  isAuthFormVisible && (
    <main className="sign-in__container">
      <div className="row m-b-20">
        <div className="col-md-8">
          {authenticated ? <TitleWithoutLogin /> : <TitleWithLogin />}

          <ClientSignUpForm />
        </div>
      </div>
    </main>
  )
)

export default Authentication
