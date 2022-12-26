import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import HeaderControls from '@components/HeaderControls'
import HeaderControlsClient from '@components/HeaderControlsClient'
import HeaderControlsDesigner from '@components/HeaderControlsDesigner'

import { hostName } from '@constants'

const Header = ({ me }) => (
  <header className="main-header bg-light">
    {me.userType
      ? <Link to={me.userType === 'client' ? '/c' : '/d'} className="main-header__logo"><img src="/logo_dark.svg" alt="logo" /></Link>
      : <a href={hostName} className="main-header__logo"><img src="/logo_dark.svg" alt="logo" /></a>
    }

    {/*!me.userType && <HeaderControls />*/}

    {me.userType === 'designer' && <HeaderControlsDesigner />}
    {me.userType === 'client' && <HeaderControlsClient />}
  </header>
)

export default Header
