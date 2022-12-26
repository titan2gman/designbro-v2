import React from 'react'
import PropTypes from 'prop-types'

import { RadioButton } from '../../inputs'

import ColorsBody from './ColorsBodyContainer'

const ColorsPicker = ({ colorsExist }) =>(
  <div className="bfs-colors-block">
    <p className="bfs-hint__text">
      Do you have specific colors that our designers should choose?
    </p>

    <div className="m-b-10">
      <label className="main-radio m-r-20">
        <RadioButton
          label="No"
          value="no"
          name="colorsExist"
        />
      </label>

      <label className="main-radio">
        <RadioButton
          label="Yes"
          value="yes"
          name="colorsExist"
        />
      </label>
    </div>

    {colorsExist && <ColorsBody />}
  </div>
)

export default ColorsPicker
