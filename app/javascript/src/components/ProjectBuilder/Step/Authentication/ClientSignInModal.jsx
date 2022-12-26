import React from 'react'
import { withRouter } from 'react-router-dom'

import Login from '@login/components/Login'
import MaterialModal from '@containers/MaterialModal'

const ClientSignInModal = ({ history }) => (
  <MaterialModal
    linkClasses="sign-in__form-link cursor-pointer"
    trigger="here"
    isClosable
    value={
      <Login
        showSaveWorkHint
        asModalWindow
        showNavigation={false}
        showRegisterHint={false}
        history={history}
      />
    }
  />
)

export default withRouter(ClientSignInModal)
