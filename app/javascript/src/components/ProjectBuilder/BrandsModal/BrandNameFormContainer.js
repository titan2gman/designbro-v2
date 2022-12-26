import { connect } from 'react-redux'

import BrandNameForm from './BrandNameForm'
import { changeAttributes } from '@actions/projectBuilder'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'

const mapStateToProps = (state) => {
  const attributes = getProjectBuilderAttributes(state)

  return {
    brandName: attributes.brandName,
    isNewBrand: !attributes.brandId
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onChange: (event) => {
      dispatchProps.changeAttributes({ [event.target.name]: event.target.value })
    },
  }
}

export default connect(mapStateToProps, {
  changeAttributes
}, mergeProps)(BrandNameForm)
