import React from 'react'

import { cutAt } from '@utils/stringProcessor'
import { humanizeProjectTypeName } from '@utils/humanizer'

const ProjectTitle = ({ brandName, productKey }) => (
  <h1 className="dpj-subheader__title main-subheader__title">
    {cutAt(brandName, 20)} - {humanizeProjectTypeName(productKey)}
  </h1>
)

export default ProjectTitle
