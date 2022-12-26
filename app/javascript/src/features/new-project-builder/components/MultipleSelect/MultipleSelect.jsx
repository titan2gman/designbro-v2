import _ from 'lodash'
import React from 'react'

import { WithContext as ReactTags } from 'react-tag-input'
import styles from './MultipleSelect.module.scss'

const MultipleSelect = ({ options, values, placeholder, onAddition, onDelete }) => {
  const suggested = options.filter((value) => {
    return !values.includes(value.id)
  })

  const handleFilterSuggestions = (value, suggestions) => {
    return suggestions.filter((s) => {
      return s.text.toLowerCase().startsWith(value.toLowerCase()) && !_.find(values, { id: s.id })
    }).slice(0, 5)
  }

  return (
    <ReactTags
      autocomplete
      allowDragDrop={false}
      inputFieldPosition="top"
      classNames={styles}
      suggestions={suggested}
      tags={values}
      placeholder={placeholder}
      handleAddition={onAddition}
      handleDelete={onDelete}
      handleFilterSuggestions={handleFilterSuggestions}
    />
  )
}

MultipleSelect.defaultProps = {
  values: []
}

export default MultipleSelect
