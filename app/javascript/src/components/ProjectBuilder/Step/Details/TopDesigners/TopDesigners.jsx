import React from 'react'
import Dinero from 'dinero.js'
import { topDesignersPrice } from '@constants/prices'

const TopDesigners = () => {
  return (
    <div className="details-step-block top-designers">
      <div className="left-icon-panel">
      </div>
      <div className="text-panel">
        <h2>Top designers</h2>
        <p>
          Only our hand-selected, professional designers will work on your project.
        </p>
      </div>

      <div className="right-panel">
        <div className="price">
          <span className="crossed">+ {Dinero({ amount: topDesignersPrice * 100 }).toFormat('$0,0.00')}</span>
          <span className="free">Free</span>
        </div>

        <button
          className="add added"
          disabled
        >
          Added
        </button>
      </div>
    </div>
  )
}

export default TopDesigners
