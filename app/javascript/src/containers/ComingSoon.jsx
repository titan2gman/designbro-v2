import React from 'react'
import { connect } from 'react-redux'

import { showModal } from '@actions/modal'

const Container = ({ children, onClick }) => (
  <children.type {...children.props} onClick={onClick} />
)

const mapDispatchToProps = {
  onClick: () => showModal(
    'COMING_SOON'
  )
}

export default connect(null, mapDispatchToProps)(Container)
