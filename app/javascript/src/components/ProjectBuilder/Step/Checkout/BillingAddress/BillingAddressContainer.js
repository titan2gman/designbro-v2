import _ from 'lodash'
import { connect } from 'react-redux'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'

import BillingAddress from './BillingAddress'

const mapStateToProps = (state) => {
  const attributes = getProjectBuilderAttributes(state)
  const vatRatesCountries = _.map(state.entities.vatRates, rate => rate.countryCode)

  return {
    isVatVisible: attributes.companyName && vatRatesCountries && vatRatesCountries.includes(attributes.countryCode)
  }
}

export default connect(mapStateToProps)(BillingAddress)
