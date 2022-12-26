import { connect } from 'react-redux'

import ProductItem from './ProductItem'

import { changeAttributes } from '@actions/projectBuilder'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'

const mapStateToProps = (state, props) => {
  const attributes = getProjectBuilderAttributes(state)

  return {
    isSelected: attributes.productId === props.product.id
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    onSelect: () => dispatchProps.changeAttributes({ productId: ownProps.product.id })
  }
}

export default connect(mapStateToProps, {
  changeAttributes
}, mergeProps)(ProductItem)
