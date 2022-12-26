import _ from 'lodash'
import { connect } from 'react-redux'
import { savePaymentSettings } from '@actions/client'
import PaymentSettings from './PaymentSettings'

const mapStateToProps = (state) => {
  const { paymentType } = state.client.settings

  return {
    paymentType
  }
}

export default connect(mapStateToProps, {
  onSave: savePaymentSettings
})(PaymentSettings)
