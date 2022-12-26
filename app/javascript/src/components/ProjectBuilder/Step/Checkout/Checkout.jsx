import React, { useEffect } from 'react'
import PropTypes from 'prop-types'

import BillingAddress from './BillingAddress'
import PaymentMethod from './PaymentMethod'

import Summary from '../Summary'
import Total from '../Total'
import Testimonial from '@client/containers/Testimonial'

import PaymentMethods from '../Details/PaymentMethods'
import MoneyBackGuarantee from '../Details/MoneyBackGuarantee'

import { Spinner } from '@components/withSpinner'

import BackButton from '../../BackButton'
import styles from './Checkout.module.scss'

const Checkout = ({ inProgress, loadProducts, loadNdaPrices, loadVatRates, loadTestimonial, onBackButtonClick }) => {
  useEffect(() => {
    loadProducts()
    loadNdaPrices()
    loadVatRates()
    loadTestimonial()
  }, [])

  if (inProgress) {
    return <Spinner />
  }

  return (
    <div className="row m-b-30">
      <div className="col-md-7">
        <BillingAddress />

        <PaymentMethod />

        <div className={styles.backButtonWrapper}>
          <BackButton className={styles.backButton} onClick={onBackButtonClick} />
        </div>
      </div>

      <div className="col-md-5 p-l-40">
        <Summary />

        <Total />

        <MoneyBackGuarantee />
        <PaymentMethods />
        <Testimonial />
      </div>
    </div>
  )
}

Checkout.propTypes = {
  inProgress: PropTypes.bool.isRequired,
}

export default Checkout
