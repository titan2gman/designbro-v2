import React from 'react'
import PropTypes from 'prop-types'

import Spinner from '@components/Spinner'

import ClientTransaction from '@client/containers/transactions/ClientTransaction'
import ClientTransactionPager from '@client/containers/transactions/ClientTransactionPager'

const ClientTransactions = ({ loading, payments }) => (
  <main>
    <div className="main-subheader">
      <div className="container">
        <div className="main-subheader__content-flex">
          <h1 className="main-subheader__title">
            Transactions
          </h1>
        </div>
      </div>
    </div>

    <div className="cltr__content container">
      <Spinner loading={loading}>
        <div className="cltr-items">
          {payments.map((payment) =>
            (<ClientTransaction
              key={payment.id}
              payment={payment}
            />)
          )}
        </div>
      </Spinner>

      <div className="text-center">
        <ClientTransactionPager />
      </div>
    </div>
  </main>
)

ClientTransactions.propTypes = {
  loading: PropTypes.bool.isRequired,
  payments: PropTypes.array.isRequired
}

export default ClientTransactions
