import React from 'react'
import { connect } from 'react-redux'

import { getMe } from '@reducers/me'

import Header from '@components/Header'

const mapStateToProps = (state) => ({
  me: getMe(state)
})

export default connect(mapStateToProps)(Header)
