import { connect } from 'react-redux'
import Dinero from 'dinero.js'
import { currentProductSelector } from '@selectors/product'
import { getCurrentProject } from '@selectors/projects'
import { humanizeProjectTypeName } from '@utils/humanizer'

import SummaryItem from '../SummaryItem'

const mapStateToProps = (state) => {
  const product = currentProductSelector(state)
  const project = getCurrentProject(state)
  const priceKey = project.projectType == 'contest' ? 'priceCents' : 'oneToOnePriceCents'

  return {
    name: humanizeProjectTypeName(product.key),
    amount: Dinero({ amount: product[priceKey] }).toFormat('$0,0.00'),
    isVisible: true
  }
}


export default connect(mapStateToProps)(SummaryItem)
