import React from 'react'

const BrandSwitcher = ({ handleBrandSwitch }) => (
  <div className="brand-hint">
    &#9666;&nbsp;
    <button className="switch-brand" onClick={handleBrandSwitch}>switch brand</button>
    &nbsp; or create &nbsp;
    <button className="switch-brand" onClick={handleBrandSwitch}>new brand</button>
  </div>
)

export default BrandSwitcher
