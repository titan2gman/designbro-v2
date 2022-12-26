import React from 'react'
import { Link } from 'react-router-dom'

const HeaderError = () => (
  <header className="main-header bg-light">
    <Link to="/" className="main-header__logo"><img src="/logo_dark.svg" alt="logo" /></Link>
  </header>
)

export default HeaderError
