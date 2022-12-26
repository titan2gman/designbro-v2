import React, { Component } from 'react'
import { connect } from 'react-redux'
import { history } from '../../../../history'
import { changeAttributes, finishProductStep } from '@actions/projectBuilder'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'
import ProductsListPage from './ProductsListPage'

class ProductsListPageContainer extends Component {
  handleBackButtonClick = () => {
    const { isOneToOne, changeAttributes } = this.props

    if (isOneToOne) {
      changeAttributes({ isDesignerChosen: false })
    } else {
      history.goBack()
    }
  }

  render() {
    return (
      <ProductsListPage {...this.props} onBackButtonClick={this.handleBackButtonClick} />
    )
  }
}

const mapStateToProps = (state) => {
  const { projectType, productId } = getProjectBuilderAttributes(state)

  return {
    isOneToOne: projectType === 'one_to_one',
    canContinue: !!productId
  }
}

export default connect(mapStateToProps, {
  changeAttributes,
  onContinue: finishProductStep
})(ProductsListPageContainer)
