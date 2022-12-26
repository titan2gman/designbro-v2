import React from 'react'

const Total = ({ value }) => {
  return (
    <div className="total">
      <h2 className="total-caption">
        Total
      </h2>

      <h2 className="total-price">
        {value}
      </h2>
    </div>
  )
}

export default Total
