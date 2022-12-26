import React from 'react'
import { Link } from 'react-router-dom'

export default () => (
  <main>
    <div className="error-page container text-center">
      <p className="error-page__text">
        Sorry this link has expired, please login&nbsp;
        <Link to="/login" className="error-page__btn-link font-18">here</Link>
      </p>
    </div>
  </main>
)
