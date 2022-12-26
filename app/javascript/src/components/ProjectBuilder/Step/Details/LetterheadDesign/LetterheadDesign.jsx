import React from 'react'

const BusinessCardDesign = () => {
  return (
    <div className="details-step-block letterhead-design">
      <div className="left-icon-panel">
      </div>
      <div className="text-panel">
        <h2>Add letterhead design</h2>
        <p>
          Get a professional unique letterhead design to match your logo.
        </p>
      </div>

      <div className="right-panel">
        <div className="price crossed">+$100</div>

        <button
          className="add"
          disabled
        >
          Added
        </button>
      </div>
    </div>
  )
}

export default BusinessCardDesign
