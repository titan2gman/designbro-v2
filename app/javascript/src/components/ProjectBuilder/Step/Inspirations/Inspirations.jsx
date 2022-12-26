import React from 'react'
import PropTypes from 'prop-types'

import { RadioButton, InspirationUploader } from '../../inputs'

const Inspirations = ({ inspirationsExist, inspirationUploaders }) => (
  <div className="bfs-existing-design">
    <p className="bfs-hint__text">
      Can you share designs that you think look great?
    </p>

    <div className="m-b-10">
      <span className="main-radio m-r-20">
        <RadioButton
          label="No"
          value="no"
          name="inspirationsExist"
        />
      </span>

      <span className="main-radio">
        <RadioButton
          label="Yes"
          value="yes"
          name="inspirationsExist"
        />
      </span>
    </div>

    {inspirationsExist && (
      <div className="bfs-content__upload-box row">
        {inspirationUploaders.map((uploader, index) => (
          <InspirationUploader
            key={index}
            index={index}
          />
        ))}
      </div>
    )}
  </div>
)

Inspirations.propTypes = {
  inspirationsExist: PropTypes.bool.isRequired,
  inspirationUploaders: PropTypes.array
}

export default Inspirations
