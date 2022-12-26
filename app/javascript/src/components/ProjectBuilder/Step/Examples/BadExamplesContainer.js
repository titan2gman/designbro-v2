import React from 'react'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'

import { getBadExamples } from '@reducers/newProject'

import BadExamples from './BadExamples'

const mapStateToProps = (state) => ({
  images: getBadExamples(state)
})

export default connect(mapStateToProps)(BadExamples)
