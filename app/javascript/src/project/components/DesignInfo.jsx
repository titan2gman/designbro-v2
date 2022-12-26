import React from 'react'
import PropTypes from 'prop-types'

import RatingStars from '@components/RatingStars'

import DesignBadge from '@project/containers/DesignBadge'

const DesignInfo = ({ rating, onRateDesign, project }) => (
  <div className="design-info">
    <DesignBadge project={project}/>
    <div>
      <RatingStars
        value={rating}
        onClick={onRateDesign}
      />
    </div>
  </div>
)

DesignInfo.propTypes = {
  onRateDesign: PropTypes.func,
  rating: PropTypes.number.isRequired
}

export default DesignInfo
