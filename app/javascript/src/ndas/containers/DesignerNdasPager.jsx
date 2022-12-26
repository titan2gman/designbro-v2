import { connect } from 'react-redux'

import Pager from '@components/Pager'

import {
  changeDesignerNdasPage,
  pureLoadDesignerNdas
} from '@actions/designerNdas'

const mapStateToProps = ({ designerNdas }) => {
  const { pager } = designerNdas

  return {
    current: pager.currentPage,
    total: pager.totalPages
  }
}

export default connect(mapStateToProps, {
  onClick: (page) => [
    changeDesignerNdasPage(page),
    pureLoadDesignerNdas()
  ]
})(Pager)
