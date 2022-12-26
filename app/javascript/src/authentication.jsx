import React from 'react'
import { compose } from 'redux'
import { Redirect } from 'react-router-dom'
import { connect } from 'react-redux'

const isDesigner = (me) => me.userType === 'designer'
const isClient = (me) => me.userType === 'client'
const isGodClient = (me) => me.god === true

const mapStateToProps = (state) => ({
  me: state.me.me
})

const composedRequireClientAuthentication = (View) => (props) => {
  if (!props.me.id) {
    return <Redirect to="/login" />
  }

  if (isDesigner(props.me)) {
    return <Redirect to="/d" />
  }

  return <View {...props} />
}

export const requireClientAuthentication = compose(
  connect(mapStateToProps),
  composedRequireClientAuthentication
)

const composedRequireGodClientAuthentication = (View) => (props) => {
  if (!props.me.id) {
    return <Redirect to="/login" />
  }

  if (isDesigner(props.me)) {
    return <Redirect to="/d" />
  }

  if (!isGodClient(props.me)) {
    return <Redirect to="/c" />
  }

  return <View {...props} />
}

export const requireGodClientAuthentication = compose(
  connect(mapStateToProps),
  composedRequireGodClientAuthentication
)

const composedRequireDesignerAuthentication = (View) => (props) => {
  if (!props.me.id) {
    return <Redirect to="/login" />
  }

  if (isClient(props.me)) {
    return <Redirect to="/c" />
  }

  return <View {...props} />
}

export const requireDesignerAuthentication = compose(
  connect(mapStateToProps),
  composedRequireDesignerAuthentication
)

const composedRequireNoAuthentication = (View) => (props) => {
  if (props.me.id && isDesigner(props.me)) {
    return <Redirect to="/d" />
  }

  if (props.me.id && isClient(props.me)) {
    return <Redirect to="/c" />
  }

  return <View {...props} />
}

export const requireNoAuthentication = compose(
  connect(mapStateToProps),
  composedRequireNoAuthentication
)
