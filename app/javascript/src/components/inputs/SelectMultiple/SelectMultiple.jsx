import React from 'react'
import PropTypes from 'prop-types'

import { WithContext as ReactTags } from 'react-tag-input'

const reactTagsClassNames = {
  tag: 'multiple-input__tag',
  remove: 'multiple-input__tag-remove',
  tagInput: 'multiple-input main-input',
  suggestions: 'multiple-input__suggestions',
  tagInputField: 'main-input__input font-16'
}

const CountriesSelect = ({ options, values, placeholder, onAdd, onDelete }) => {
  const suggested = options.filter((value) => {
    return !values.includes(value.id)
  })

  return (
    <ReactTags
      autocomplete
      classNames={reactTagsClassNames}
      handleDelete={onDelete}
      suggestions={suggested}
      tags={values}
      handleAddition={onAdd}
      placeholder={placeholder}
    />
  )
}

CountriesSelect.propTypes = {
  onAdd: PropTypes.func.isRequired,
  onDelete: PropTypes.func.isRequired,
  values: PropTypes.arrayOf(PropTypes.object),
  options: PropTypes.arrayOf(PropTypes.object),
}

CountriesSelect.defaultProps = {
  values: []
}

export default CountriesSelect
