import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import HeaderControls from '@components/HeaderControls'
import HeaderControlsClient from '@components/HeaderControlsClient'
import HeaderControlsDesigner from '@components/HeaderControlsDesigner'

import { hostName } from '@constants'

const Header = ({ me }) => (
  <header className="bg-black">
    <div className="container main-header">
      {me.userType
        ? <Link to="/" className="main-header__logo"><img src="/logo_light.svg" alt="logo" /></Link>
        : <a href={hostName} className="main-header__logo"><img src="/logo_light.svg" alt="logo" /></a>
      }

      {/*!me.userType && <HeaderControls />*/}

      {me.userType === 'designer' && <HeaderControlsDesigner />}
      {me.userType === 'client' && <HeaderControlsClient />}
    </div>
  </header>
)

export default Header
