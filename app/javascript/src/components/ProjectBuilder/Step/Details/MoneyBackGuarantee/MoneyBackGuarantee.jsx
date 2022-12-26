import React from 'react'

const MoneyBackGuarantee = () => {
  return (
    <div className="money-back-guarantee">
      <div className="money-back-guarantee-headline">
        <div className="checkmark">
          <div className="checkmark_circle"></div>
          <div className="checkmark_stem"></div>
          <div className="checkmark_kick"></div>
        </div>
        <h2>Money Back Guarantee</h2>
      </div>

      <p>
        99% happy customers. We want to keep it that way. Conditions apply - See
        our <a href="https://designbro.com/our-refund-policy" className="money-back-guarantee-refund" target="blank">refund policy.</a>
      </p>
    </div>
  )
}

export default MoneyBackGuarantee
