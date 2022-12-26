import React from 'react'

import { history } from '../../../history'

export default () => (
  <main>
    <div className="error-page container text-center">
      <img src="/error404.png" srcSet="/error404_2x.png 2x" alt="error400" className="error-page__img" />
      <p className="error-page__text">
        Shucks... We can't seem to find that page...
        <br />
        Must be in the same place as our coloring pencils
      </p>
      <a href="#" onClick={history.goBack} className="error-page__btn-link">
        <i className="icon-arrow-left-circle m-r-10 align-middle font-40" />
        Go Back
      </a>
    </div>
  </main>
)
