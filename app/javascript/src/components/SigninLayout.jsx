import React from 'react'
import Footer from '@containers/Footer'
import { hostName } from '@constants'

const SigninLayout = ({ children }) => (
  <div className="page-container sign-in__page-container">
    <header className="container main-header">
      <a href={hostName} className="main-header__logo"><img src="/logo_light.svg" alt="logo" /></a>
    </header>

    {children}

    <Footer />
  </div>
)

export default SigninLayout
