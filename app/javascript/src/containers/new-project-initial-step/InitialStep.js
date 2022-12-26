import _ from 'lodash'
import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { withSpinner } from '@components/withSpinner'
import { withRouter } from 'react-router-dom'

import {
  changeProjectProductAttributes,
  createProject
} from '@actions/newProject'

// import InspirationsStep from '../new-project-inspirations-step/InspirationsStep'
import PackagingTypeStep from '../new-project-packaging-type-step/PackagingTypeStep'
// import StyleStep from '../new-project-style-step/StyleStep'

class InitialStep extends Component {
  componentWillMount () {
    const { productId, changeProjectProductAttributes, createProject } = this.props

    changeProjectProductAttributes('isNewBrand', true)
    changeProjectProductAttributes('brandId', null)
    changeProjectProductAttributes('productId', productId)

    createProject()
  }

  render () {
    const productKey = this.props.match.params.productKey

    if (productKey === 'packaging') {
      return (
        <PackagingTypeStep />
      )
    }
    // if (['logo', 'brand-identity'].includes(productKey)) {
    //   return (
    //     <InspirationsStep />
    //   )
    // }

    const handleContinueButtonClick = () => {
      this.props.saveProjectStyleAttributes(this.props.history, 'audience')
    }

    return (
      null
      // <StyleStep
      //   onContinueButtonClick={handleContinueButtonClick}
      // />
    )
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
    changeProjectProductAttributes,
    createProject
  }),
  withRouter,
  withSpinner
)(InitialStep)
