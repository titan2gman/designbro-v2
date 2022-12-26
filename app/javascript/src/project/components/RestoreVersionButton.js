import React, { Component, useEffect, useState } from 'react'

const RestoreVersionButton = ({ onClick, selectedDesignId, open }) => {
  const [active, setActive] = useState(false)

  const handleClick = () => {
    const onSuccess = open({
      title: 'Design',
      message: 'Your design was successfully updated!'
    })
    onClick(selectedDesignId).then(onSuccess)
  }

  useEffect(() => {
    if (selectedDesignId !== null) {
      setActive(true)
    }
  }, [selectedDesignId])

  return (
    <button
      id="restore-version-btn"
      onClick={handleClick}
      className="conv-actions__btn-darkgrey-positive"
      style={active ? { backgroundColor: '#18da8e', borderColor: '#18da8e', color: '#fff' } : {}}
    >
      Restore version
    </button>
  )
}

export default RestoreVersionButton
