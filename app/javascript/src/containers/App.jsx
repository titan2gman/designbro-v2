import React from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Intercom from 'react-intercom'

import { getMe, isAuthenticated } from '@reducers/me'

import ModalRoot from '@containers/ModalRoot'
import SimpleModal from '@containers/SimpleModal'

const App = ({ user, children }) => (
  <>
    {children}

    <ModalRoot />
    <SimpleModal />
    {window.intercom_app_id && <Intercom appID={window.intercom_app_id} {...user} />}
  </>
)

App.propTypes = {
  children: PropTypes.node
}

const mapStateToProps = (state) => {
  const me = getMe(state)
  const user = isAuthenticated(state) ? {
    user_id: me.userId,
    email: me.email,
    name: `${me.firstName} ${me.lastName}`,
    user_hash: me.userHash,
    created_at: new Date(me.createdAt).getTime() / 1000
  } : {}

  return {
    user
  }
}

export default connect(mapStateToProps)(App)
