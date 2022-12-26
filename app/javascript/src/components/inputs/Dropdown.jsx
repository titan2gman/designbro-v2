import React from 'react'
import { Dropdown } from 'semantic-ui-react'

// RRF <=> Semantic UI.
const transform = (fn) =>
  (e, { value }) =>
    fn(value)

const RRFDropdown = (props) => <Dropdown {...props} onChange={transform(props.onChange)} />

export default RRFDropdown
