import React from 'react'
import PropTypes from 'prop-types'

import { Input } from '../../../inputs'

const Discount = ({ discountCode, isValid, inProgress, onChange }) => (
  <div className="discount">
    <div className="label">
      Got a discount code?
    </div>

    <div className="input">
      <Input
        name="discountCode"
        onChange={onChange}
        autoComplete="off"
      />
    </div>

    <div className="validation">
      {discountCode && !inProgress && isValid && <i key="valid-check" className="icon-check in-green-300 font-12 font-bold" />}
      {discountCode && !inProgress && !isValid && <i className="icon-cross in-red-500 font-12 font-bold" />}
    </div>
  </div>
)

export default Discount
