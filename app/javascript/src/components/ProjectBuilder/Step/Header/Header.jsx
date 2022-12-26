import React from 'react'

const Header = ({ name, description }) => (
  <div className="main-subheader">
    <h1 className="bfs-subheader__title main-subheader__title">
      {name}
    </h1>

    <p className="bfs-subheader__hint">
      {description}
    </p>
  </div>
)

export default Header
