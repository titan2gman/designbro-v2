import React, { Component } from 'react'
import classNames from 'classnames'

import {
  CardNumberElement,
  CardExpiryElement,
  CardCVCElement,
  injectStripe
} from 'react-stripe-elements'

import PaymentMethod from '../../inputs/PaymentMethod'
import Button from '@components/Button'
import ErrorMessage from './ErrorMessage'

import styles from './StripePaymentForm.module.scss'

const stripeElementStyle = {
  base: {
    fontSize: '18px',
    color: '#424770',
    letterSpacing: '0.025em',
    fontFamily: 'Source Code Pro, monospace',
    '::placeholder': {
      color: '#aab7c4',
    },
  },
  invalid: {
    color: '#9e2146',
  }
}

class StripePaymentForm extends Component {
  state = {
    isButtonFrozen: false,
    isCardFormVisible: false
  }

  componentDidMount() {
    this._isMounted = true
  }

  componentWillUnmount() {
    this._isMounted = false
  }

  _isMounted = false

  freezeCallback = () => {
    this.setState({
      isButtonFrozen: true
    })
  }

  errorCallback = () => {
    if (this._isMounted) {
      this.setState({
        isButtonFrozen: false
      })
    }
  }

  successCallback = () => {
    if (this._isMounted) {
      this.setState({
        isButtonFrozen: false,
        isCardFormVisible: false
      })
    }
  }

  handleFieldsSubmit = (e) => {
    this.freezeCallback()
    e.preventDefault()

    const { stripe, onSuccess, onError } = this.props

    if (stripe) {
      stripe.createPaymentMethod('card').then((result) => {
        if (result.error) {
          onError && onError(result).then(this.errorCallback) || this.errorCallback()
        } else {
          onSuccess(result.paymentMethod).then(this.successCallback)
        }
      })
    } else {
      console.log('Stripe.js hasn\'t loaded yet.')
    }
  }

  handleButtonSubmit = (e) => {
    this.freezeCallback()
    e.preventDefault()

    const { stripe, onSuccess, onError } = this.props

    if (stripe) {
      onSuccess().then(this.successCallback)
    } else {
      console.log('Stripe.js hasn\'t loaded yet.')
    }
  }

  render () {
    const { isButtonFrozen, isCardFormVisible } = this.state
    const { error, creditCardNumber, creditCardProvider, buttonText } = this.props
    const hasCard = creditCardNumber && creditCardProvider

    return !hasCard || isCardFormVisible ? (
      <form className="stripe-form" onSubmit={this.handleFieldsSubmit}>
        <div className="row">
          <div className="col-xs-8">
            <label>
              Card number
              <CardNumberElement
                style={stripeElementStyle}
              />
            </label>

            <label>
              Expiration date
              <CardExpiryElement
                style={stripeElementStyle}
              />
            </label>

            <label>
              CVC
              <CardCVCElement
                style={stripeElementStyle}
              />
            </label>
          </div>
        </div>

        <ErrorMessage />

        <Button
          disabled={isButtonFrozen}
          waiting={isButtonFrozen}
          className={styles.btn}
        >
          {buttonText}
        </Button>
      </form>
    ) : (
      <>
        <PaymentMethod
          creditCardNumber={creditCardNumber}
          creditCardProvider={creditCardProvider}
          onChange={() => { this.setState({ isCardFormVisible: true }) }}
        />

        <ErrorMessage />

        <Button
          disabled={isButtonFrozen}
          waiting={isButtonFrozen}
          className={styles.btn}
          onClick={this.handleButtonSubmit}
        >
          {buttonText}
        </Button>
      </>
    )
  }
}

const DefaultButtonText = () => (
  <>
    Pay now & start
    <i className={classNames(styles.icon, 'icon-arrow-right')} />
  </>
)

StripePaymentForm.defaultProps = {
  areFieldsVisible: true,
  buttonText: <DefaultButtonText />
}

export default injectStripe(StripePaymentForm)
