import React from 'react'
import { compose } from 'redux'
import { withRouter, Redirect } from 'react-router-dom'
import { connect } from 'react-redux'

const mapStateToProps = (state) => {
  const me = state.me.me

  return {
    me
  }
}

const composedDesignerGuard = (View) => (props) => {

  return <View {...props} />
}

export const withDesignerGuard = compose(
  withRouter,
  connect(mapStateToProps),
  composedDesignerGuard
)
