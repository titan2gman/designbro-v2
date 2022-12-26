import { connect } from 'react-redux'

import { changePage } from '@actions/brands'

import Pager from '../Pager'

const mapStateToProps = (state, props) => {
  const { pager } = state.brands

  return {
    total: pager.totalPages,
    current: pager.currentPage
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  const { dispatch } = dispatchProps

  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,

    onClick: (page) => [
      dispatch(changePage(page)),
      ownProps.loadBrands()
    ]
  }
}

export default connect(mapStateToProps, null, mergeProps)(Pager)
