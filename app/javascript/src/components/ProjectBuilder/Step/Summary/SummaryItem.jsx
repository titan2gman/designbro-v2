import React from 'react'
import PropTypes from 'prop-types'

const SummaryItem = ({ isVisible, name, amount, isFree }) => {
  if (!isVisible) {
    return null
  }
  
  return (
    <div className="summary-item">
      <span className="summary-item-name">
        {name}
      </span>
      
      <span className="summary-item-price">
        {isFree ? <span className="crossed">{amount}</span> : amount}
        {isFree && <span className="free">Free</span>}
      </span>
    </div>
  )
}

SummaryItem.propTypes = {
  isFree: PropTypes.bool,
  isVisible: PropTypes.bool,
  name: PropTypes.string,
  amount: PropTypes.string
}

SummaryItem.defaultProps = {
  isFree: false
}

export default SummaryItem
