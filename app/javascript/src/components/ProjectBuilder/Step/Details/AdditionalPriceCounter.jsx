import React from 'react'

const AdditionalPriceCounter = ({ count, minCount, maxCount, isAdditionalPriceZero, additionalPrice, onUp, onDown, title, description }) => (
  <div className="details-step-block designs-counter">
    <div className="text-panel">
      <h2>{title}</h2>
      <p>
        {description}
      </p>
    </div>
    
    <div className="right-panel">
      <button
        className="down"
        disabled={count <= minCount}
        onClick={onDown}
      />
      
      <div className="count-wrapper">
        <div className="count">
          {count}
        </div>
        
        <div className="price">{isAdditionalPriceZero ? 'included' : `+ ${additionalPrice}`}</div>
      </div>
      <button
        className="up"
        disabled={count >= maxCount}
        onClick={onUp}
      />
    </div>
  </div>
)

export default AdditionalPriceCounter
