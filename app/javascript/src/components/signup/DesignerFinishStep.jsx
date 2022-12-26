import React from 'react'
import { Link } from 'react-router-dom'

import { staticHost } from '@utils/hosts'

import CurrentUserPic from '../../containers/CurrentUserPic'

const Finish = () => (
  <main className="join-complete container page-main">
    <div className="row">
      <div className="col-xs-12 col-lg-4 offset-lg-4">
        <CurrentUserPic className="join-complete__userpic" />

        <h1 className="join-complete__title">
          Great, thank you!
        </h1>

        <p className="join-complete__text">
          Let us take a look at your work and we’ll get back to you as soon as we can. This can take some time; we get a lot of good portfolios. Please bear with us in the meantime!
          <br />
          If you have any issues or questions, <a href={`${staticHost}/contact-us`} className="in-black text-underline no-wrap">drop us a line.</a>
        </p>

        <Link to="/d" className="main-button main-button--md main-button--black-pink m-b-20">
          Dashboard
        </Link>
      </div>
    </div>
  </main>
)

export default Finish
