import React from 'react'
import PropTypes from 'prop-types'
import { countriesList } from '@constants'

import {
  Input,
  Select
} from '../../../inputs'

const BillingAddressForm = ({ isVatVisible }) => (
  <div className="m-b-55">
    <p className="font-bold">
      Billing Address:
    </p>

    <div className="row">
      <div className="col-sm-6">
        <Input
          name="firstName"
          label="First Name"
        />
      </div>

      <div className="col-sm-6">
        <Input
          name="lastName"
          label="Last Name"
        />
      </div>
    </div>

    <Select
      name="countryCode"
      options={countriesList}
      placeholder="Country"
    />

    <Input
      name="companyName"
      label="Company name (optional)"
    />

    {isVatVisible && (
      <Input
        name="vat"
        label="VAT number (optional)"
      />
    )}
  </div>
)

BillingAddressForm.propTypes = {
  isVatVisible: PropTypes.bool,
}

export default BillingAddressForm
