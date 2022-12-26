import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'

import { saveStep } from '@actions/projectBuilder'

import { currentProductShortNameSelector } from '@selectors/product'

import { getProjectBuilderStep } from '@selectors/projectBuilder'

import StockImages from './StockImages'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step

  return {
    openStep: getProjectBuilderStep(state, stepName),
    productName: currentProductShortNameSelector(state),
    stockImagesExist: state.projectBuilder.attributes.stockImagesExist,
    stockImageUploaders: state.projectBuilder.attributes.projectStockImages,
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onChange: () => dispatchProps.saveStep(stateProps.openStep)
  }
}

export default withRouter(connect(mapStateToProps, {
  saveStep
}, mergeProps)(StockImages))
