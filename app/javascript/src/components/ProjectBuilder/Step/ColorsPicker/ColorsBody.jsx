import React from 'react'
import PropTypes from 'prop-types'

import { Textarea, ColorPicker } from '../../inputs'

const ColorsBody = ({ colors }) => (
  <main>
    <div className="row">
      {colors.map((color, index) => (
        <ColorPicker
          key={index}
          index={index}
          color={color}
        />
      ))}
    </div>

    <div className="row">
      <div className="col-md-8">
        <Textarea
          label="or enter your Pantone/RGB/CMYK or HEX code manually"
          name="colorsComment"
        />
      </div>
    </div>
  </main>
)

ColorsBody.propTypes = {
  colors: PropTypes.arrayOf(
    PropTypes.string
  ).isRequired,
}

export default ColorsBody
