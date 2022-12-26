import React from 'react'
import classNames from 'classnames'

const BrandIdentity = ({ upgradePackage, price, onToggle }) => (
  <div className="details-step-block brand-identity">
    <div className="left-icon-panel">
    </div>
    <div className="text-panel">
      <h2>Add full brand identity</h2>
      <p>
        Make sure you have a set that works together perfectly & ensure a professional identity.
        Includes: Business card design, Letterhead design, Compliment slips design.
      </p>
    </div>

    <div className="right-panel">
      <div className="price">+ {price}</div>

      <button
        className={classNames('add', { added: upgradePackage })}
        onClick={onToggle}
      >
        {upgradePackage ? <span>Added</span> : 'Add'}
      </button>
    </div>
  </div>
)

export default BrandIdentity
