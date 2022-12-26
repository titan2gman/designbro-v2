import React from 'react'
import { connect } from 'react-redux'

import { getMe } from '@reducers/me'

import HeaderLight from '@components/HeaderLight'

const mapStateToProps = (state) => ({
  me: getMe(state)
})

export default connect(mapStateToProps)(HeaderLight)
