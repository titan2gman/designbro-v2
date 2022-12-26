import _ from 'lodash'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import { withSpinner } from '@components/withSpinner'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'
import queryString from 'query-string'

import {
  changeAttributes
} from '@actions/projectBuilder'

import {
  showInitialBrandsModal
} from '@actions/modal'

import NewProject from './NewProject'

const mapStateToProps = (state) => {
  const attributes = getProjectBuilderAttributes(state)
  const projectType = attributes.projectType
  const isDesignerChosen = attributes.isDesignerChosen
  const brandIds = state.brands.ids
  const hasBrands = brandIds.length > 0

  return {
    hasBrands,
    brandIds,
    inProgress: state.brands.inProgress || state.products.inProgress || state.vatRates.inProgress,
    isProductsPageVisible: !hasBrands || projectType === 'contest' || (projectType === 'one_to_one' && isDesignerChosen),
    isDesignersPageVisible: projectType === 'one_to_one' && !isDesignerChosen,
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onLoad: () => {
      const brandId = queryString.parse(location.search).brand_id

      if (_.includes(stateProps.brandIds, brandId)) {
        dispatchProps.changeAttributes({ brandId })
      }

      if (stateProps.hasBrands) {
        dispatchProps.showInitialBrandsModal()
      }
    }
  }
}

export default withRouter(connect(mapStateToProps, {
  changeAttributes,
  showInitialBrandsModal
}, mergeProps)(withSpinner(NewProject)))
