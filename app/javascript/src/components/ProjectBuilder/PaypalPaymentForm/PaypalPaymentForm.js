import PropTypes from 'prop-types'
import classNames from 'classnames'
import React, { Component } from 'react'

class PaypalPaymentForm extends Component {
  componentDidMount () {
    const { amount, onSuccess } = this.props
    const self = this
    const env = window.PayPalEnv
    const key = window.PayPalKey

    if (window.env !== 'test') {
      if (!self.paypalButtonExists()) return
      if (self.paypalButtonAlredyRendered()) return
      window.paypal.Button.render({
        env: env,

        client: { [env]: key },

        payment: function () {
          const env = this.props.env
          const client = this.props.client

          return window.paypal.rest.payment.create(env, client, {
            transactions: [
              {
                amount: {
                  total: amount,
                  currency: 'USD'
                }
              }
            ]
          })
        },

        commit: true, // Optional: show a 'Pay Now' button in the checkout flow

        onAuthorize: function (data, actions) {
          return actions.payment.execute().then(onSuccess)
        }
      }, '#paypal-button')
    }
  }

  paypalButtonExists () {
    return !!document.getElementById('paypal-button')
  }

  paypalButtonAlredyRendered () {
    return document.getElementById('paypal-button') && document.getElementById('paypal-button').children.length > 0
  }

  render () {
    return (
      <div className="text-center">
        <div id="paypal-button" className="inline-block" />
      </div>
    )
  }
}

PaypalPaymentForm.propTypes = {
  onSuccess: PropTypes.func.isRequired,
  amount: PropTypes.string.isRequired
}

export default PaypalPaymentForm
