import { connect } from 'react-redux'

import NewBrand from './NewBrand'

import { changeAttributes } from '@actions/projectBuilder'

const mapStateToProps = (state) => {
  return {
    isSelected: !state.projectBuilder.attributes.brandId
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onSelect: () => dispatchProps.changeAttributes({ brandId: null })
  }
}

export default connect(mapStateToProps, {
  changeAttributes
}, mergeProps)(NewBrand)
