import _ from 'lodash'
import { connect } from 'react-redux'
import { showDeliverablesModal } from '@actions/modal'

import DesignerDeliverables from '@components/designer/DesignerDeliverables'

const mapStateToProps = (state) => {
  const products = _.values(state.entities.products)

  const columnsCount = 3
  const chunkSize = Math.ceil(products.length / columnsCount)
  const chunkedProducts = _.chunk(products, chunkSize)

  return {
    products: chunkedProducts
  }
}

export default connect(mapStateToProps, {
  showDeliverablesModal
})(DesignerDeliverables)
