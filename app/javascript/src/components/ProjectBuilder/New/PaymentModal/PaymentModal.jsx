import React, { useState } from 'react'
import classNames from 'classnames'
import { Modal } from 'semantic-ui-react'
import styles from './PaymentModal.module.scss'
import { RadioButton } from '../../inputs'

import PaymentSummaryItem from '../PaymentSummaryItem'
import PaypalPaymentForm from '../../PaypalPaymentForm'
import StripePaymentForm from '../../StripePaymentForm'
import PaymentMethod from '../../../inputs/PaymentMethod'
import Discount from '../Discount'

const PaymentModal = ({
  paymentType,
  basePriceName,
  basePriceValue,
  isVatVisible,
  vatValue,
  totalValue,
  paypalAmount,
  creditCardNumber,
  creditCardProvider,
  hasCard,
  isDiscountVisible,
  discountAmount,

  className,
  onPaypalSuccess,
  onStripeSuccess,
  onClose
}) => {
  const [isCardFormVisible, showCardForm] = useState(false)

  return (
    <Modal
      open
      className={classNames('main-modal main-modal--xs', className)}
      size="tiny"
      onClose={onClose}
    >
      <div className={styles.modalBody}>
        {onClose && <div className={classNames('icon-cross', styles.closeIcon)} onClick={onClose} />}

        <div className={styles.modalHeader}>
          <h2>Payment</h2>
          <span></span>
        </div>

        <div className={styles.modalContent}>
          <PaymentSummaryItem
            isVisible
            name={basePriceName}
            value={basePriceValue}
          />

          <PaymentSummaryItem
            isVisible={isVatVisible}
            name="VAT"
            value={vatValue}
          />

          <PaymentSummaryItem
            isVisible={isDiscountVisible}
            name="Discount"
            value={discountAmount}
          />

          <div className={styles.total}>
            <h2 className={styles.totalCaption}>
              Total
            </h2>

            <h2 className={styles.totalPrice}>
              {totalValue}
            </h2>
          </div>

          <Discount />

          <h4 className={styles.title}>Payment Method</h4>

          <div>
            <span className="prjb-radio prjb-checkout-radio main-radio">
              <RadioButton
                label="Credit card"
                value="credit_card"
                name="paymentType"
              />
            </span>

            <span className="prjb-radio prjb-checkout-radio main-radio">
              <RadioButton
                label="PayPal"
                value="paypal"
                name="paymentType"
              />
            </span>
          </div>

          {paymentType === 'paypal' && (
            <PaypalPaymentForm
              amount={paypalAmount}
              onSuccess={onPaypalSuccess}
            />
          )}

          {paymentType === 'credit_card' && (
            <StripePaymentForm
              creditCardNumber={creditCardNumber}
              creditCardProvider={creditCardProvider}
              onSuccess={onStripeSuccess}
            />
          )}
        </div>
      </div>
    </Modal>
  )
}

export default PaymentModal
