import { connect } from 'react-redux'

import BrandItem from './BrandItem'

import { changeAttributes } from '@actions/projectBuilder'

const mapStateToProps = (state, props) => {
  return {
    isSelected: state.projectBuilder.attributes.brandId === props.brand.id
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onSelect: () => dispatchProps.changeAttributes({ brandId: ownProps.brand.id })
  }
}

export default connect(mapStateToProps, {
  changeAttributes
}, mergeProps)(BrandItem)
