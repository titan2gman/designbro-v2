import React from 'react'

const SearchPanel = ({ name, onNameChange }) => {
  return (
    <div className="search-field search-field--grey">
      <input
        placeholder="Search brand..."
        type="text"
        className="search-field__input"
        onChange={onNameChange}
        value={name}
      />
      <i className="search-field__icon icon-search"/>
    </div>
  )
}

export default SearchPanel
