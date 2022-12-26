import React from 'react'

import DesignerTile from './DesignerTile'

const DesignersList = ({ winners }) => {
  return (
    <div className="row">
      {winners.map((winner, index) => (
        <DesignerTile key={index} winner={winner} />
      ))}
    </div>
  )
}

export default DesignersList
