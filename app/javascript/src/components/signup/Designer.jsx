import React from 'react'
import { Link } from 'react-router-dom'

import { staticHost } from '@utils/hosts'

import Navigation from './Navigation'

import EmailDesignerForm from '../../containers/signup/EmailDesignerForm'

const LoginHint = () =>
  (<p className="sign-in__form-text-md">
    Already have an account? <Link className="sign-in__form-link-pink" to="/login">Login</Link>
  </p>)

const ClientCategorySelect = () =>
  (<p className="sign-in__form-text">
    Want to start a design project as a client? <a href={`${staticHost}/design-project-types`} className="sign-in__form-link in-black no-wrap">Select category first</a>
  </p>)

const RequestJoin = () =>
  (<main className="sign-in__container">
    <div className="sign-in__form">
      <Navigation />
      <EmailDesignerForm />
      <LoginHint />
      <ClientCategorySelect />
    </div>
  </main>)

export default RequestJoin
