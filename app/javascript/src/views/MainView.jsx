import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom'

const mapStateToProps = (state) => ({
  me: state.me.me
})

const isDesigner = (me) => me.userType === 'designer'

const MainView = ({ me }) => {
  if (!me.id) {
    return <Redirect to="/login" />
  }

  if (isDesigner(me)) {
    return <Redirect to="/d" />
  }

  return <Redirect to="/c" />
}

export default connect(mapStateToProps)(MainView)
