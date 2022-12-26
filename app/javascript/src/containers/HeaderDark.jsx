import React from 'react'
import { connect } from 'react-redux'

import { getMe } from '@reducers/me'

import HeaderDark from '@components/HeaderDark'

const mapStateToProps = (state) => ({
  me: getMe(state)
})

export default connect(mapStateToProps)(HeaderDark)
