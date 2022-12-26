import React from 'react'

export default () => (
  <main>
    <div className="error-page container text-center">
      <img src="/error500.png" srcSet="/error500_2x.png 2x" alt="error500" className="error-page__img" />
      <p className="error-page__text">
        Whooops... That's really not supposed to happen!
        <br />
        We promise we're working on fixing it...
        <br />
        Check our status on
        <a target="_blank" href="https://twitter.com/designbrodotcom" className="error-page__link">Twitter</a>
      </p>
      <i className="error-page__icon icon-twitter-circle" />
    </div>
  </main>
)
