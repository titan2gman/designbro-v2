import filter from 'lodash/filter'
import toLower from 'lodash/toLower'
import startsWith from 'lodash/startsWith'

import PropTypes from 'prop-types'
import classNames from 'classnames'
import countries from 'country-list'
import React, { Component } from 'react'
import AutoSuggest from 'react-autosuggest'

const countryNames = countries.getNames()

const theme = {
  suggestionsContainer: 'multiple-input__suggestions',
  suggestionFocused: 'active'
}

const renderSuggestion = (suggestion) => (
  <div>{suggestion}</div>
)

// TODO: fix eslint react/display-name

const renderInputComponent = ({ onFocus, onBlur, label }) => (props) => (
  <div className="main-input__input-box">
    <input
      {...props}
      name="country"
      className="main-input__input"
    />

    <label
      htmlFor="country-code"
      className="main-input__label"
    >
      {label}
    </label>
  </div>
)

const getSuggestions = (value = '') => {
  return filter(countryNames, (countryName) =>
    startsWith(toLower(countryName), toLower(value))
  )
}

class MaterialCountryInput extends Component {
  state = {
    value: '',
    suggestions: getSuggestions()
  }

  onSuggestionsFetchRequested = ({ value }) => {
    this.setState({ suggestions: getSuggestions(value) })
  }

  handleChange = (_, { newValue }) => {
    const { name, onChange, onBlur } = this.props

    this.setState({
      value: newValue
    })

    const countryCode = countries.getCode(newValue) || ''

    onChange(name, countryCode)
    onBlur && onBlur()
  }

  render () {
    const { error, name } = this.props
    const { value, suggestions } = this.state
    const countryName = this.props.value && countries.getName(this.props.value) || ''

    return (
      <div
        className={classNames('main-input', {
          'is-focused': (value || this.props.value),
          'is-invalid': !!error
        })}
      >
        <AutoSuggest
          onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
          renderInputComponent={renderInputComponent(this.props)}
          onSuggestionsClearRequested={() => {}}
          getSuggestionValue={(value) => value}
          renderSuggestion={renderSuggestion}
          inputProps={{
            value: countryName || value,
            onChange: this.handleChange,
            onBlur: this.handleBlur
          }}
          suggestions={suggestions}
          theme={theme}
        />

        {error && (
          <div className="main-input__hint in-pink-500">{error}</div>
        )}
      </div>
    )
  }
}

MaterialCountryInput.propTypes = {
  label: PropTypes.string,
  onBlur: PropTypes.func
}

MaterialCountryInput.defaultProps = {
  label: 'Country'
}

export default MaterialCountryInput
