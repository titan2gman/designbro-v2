import React from 'react'
import classNames from 'classnames'

import StandardNdaModal from '../StandardNdaModal'

const Nda = ({ price, isAdded, onToggle }) => (
  <div className="details-step-block nda">
    <div className="left-icon-panel">
    </div>
    <div className="text-panel">
      <h2>Make it a secret (NDA)</h2>
      <p>
        Keep your project a total secret by getting our designers to agree to a confidentiality agreement before they get to see your briefings.
        See the text <StandardNdaModal/>.
      </p>
    </div>

    <div className="right-panel">
      <div className="price">+ {price}</div>

      <button
        className={classNames('add', { added: isAdded })}
        onClick={onToggle}
      >
        {isAdded ? <span>Added</span> : 'Add'}
      </button>
    </div>
  </div>
)

export default Nda
