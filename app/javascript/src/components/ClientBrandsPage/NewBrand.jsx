import React from 'react'
import { Link } from 'react-router-dom'

const NewBrand = () => (
  <div className="col-md-4 col-sm-6 col-xs-12">
    <Link to="/projects/new">
      <div className="brand-item new-brand">
        <div className="plus">+</div>
        <div className="start">Start a<br/>new project<br/>or brand</div>
      </div>
    </Link>
  </div>
)

export default NewBrand
