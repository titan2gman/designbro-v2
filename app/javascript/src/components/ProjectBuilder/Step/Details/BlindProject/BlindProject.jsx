import React from 'react'
import Dinero from 'dinero.js'
import { blindProjectPrice } from '@constants/prices'

const BlindProject = () => (
  <div className="details-step-block blind-project">
    <div className="left-icon-panel">
    </div>
    <div className="text-panel">
      <h2>Blind project</h2>
      <p>
        Designers can`t see each other`s work, so you receive more creativity and originality.
      </p>
    </div>

    <div className="right-panel">
      <div className="price">
        <span className="crossed">+ {Dinero({ amount: blindProjectPrice * 100 }).toFormat('$0,0.00')}</span>
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

export default BlindProject
