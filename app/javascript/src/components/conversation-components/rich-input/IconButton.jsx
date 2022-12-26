import React, { useCallback, useState } from 'react'

const IconButton = ({ id, onClick, imageSrc, imageSrcActive, active, style }) => (
  <button
    id={id}
    onClick={onClick}
    className="icon-btn"
    style={{ ...style, backgroundImage: `url('${active ? imageSrcActive : imageSrc}')` }}
    onMouseOver={() => event.target.style.backgroundImage = `url('${imageSrcActive}')`}
    onMouseLeave={() => event.target.style.backgroundImage = `url('${active ? imageSrcActive : imageSrc}')`}
  />
)

export default IconButton
