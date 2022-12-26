import _ from 'lodash'
import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withSpinner, Spinner } from '@components/withSpinner'
import { withRouter } from 'react-router-dom'

import {
  changeAttributes,
  createContestProject
} from '@actions/projectBuilder'

class InitialStep extends Component {
  componentWillMount () {
    const { productId, changeAttributes, createContestProject } = this.props

    changeAttributes({
      brandId: null,
      productId: productId,
      projectType: 'contest'
    })

    createContestProject()
  }

  render () {
    return <Spinner />
  }
}

const mapStateToProps = (state, props) => {
  const productKey = props.match.params.productKey
  const inProgress = state.products.inProgress

  if (inProgress) {
    return {
      inProgress
    }
  }

  return {
    inProgress,
    productId: _.find(state.entities.products, (product) => product.key === productKey).id
  }
}

export default compose(
  connect(mapStateToProps, {
    changeAttributes,
    createContestProject
  }),
  withRouter,
  withSpinner
)(InitialStep)
