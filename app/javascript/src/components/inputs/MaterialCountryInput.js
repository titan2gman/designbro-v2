import filter from 'lodash/filter'
import toLower from 'lodash/toLower'
import startsWith from 'lodash/startsWith'

import PropTypes from 'prop-types'
import classNames from 'classnames'
import countries from 'country-list'
import React, { Component } from 'react'
import AutoSuggest from 'react-autosuggest'
import { Control, Field, Errors } from 'react-redux-form'

import ErrorWrapper from '@components/ErrorWrapper'

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
      {...props} name="country"
      className="main-input__input"
      onBlur={() => onBlur() || props.onBlur()}
      onFocus={() => onFocus() || props.onFocus()}
    />

    <label
      htmlFor="country-code"
      className="main-input__label">

      {label}
    </label>
  </div>
)

const getSuggestions = (value = '') => {
  return filter(countryNames, (countryName) =>
    startsWith(toLower(countryName), toLower(value))
  )
}

const needToShowErrors = ({ touched, valid }) => (
  touched && !valid
)

const inputContainerClassName = (props) => {
  const showErrors = needToShowErrors(props)

  return classNames('main-input', {
    'is-focused': props.value,
    'is-invalid': showErrors
  })
}

class MaterialCountryInput extends Component {
  state = { suggestions: getSuggestions() }

  onSuggestionsFetchRequested = ({ value }) => {
    this.setState({ suggestions: getSuggestions(value) })
  }

  render () {
    const { value, id } = this.props
    const { suggestions } = this.state

    const onChange = (_, { newValue }) => (
      this.props.onChange(newValue)
    )

    return (
      <AutoSuggest
        onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
        renderInputComponent={renderInputComponent(this.props)}
        onSuggestionsClearRequested={() => {}}
        getSuggestionValue={(value) => value}
        renderSuggestion={renderSuggestion}
        inputProps={{ value, onChange, id }}
        suggestions={suggestions}
        theme={theme}
      />
    )
  }
}

const MaterialCountryInputWrapper = ({ id, onBlur, model, label, validators, messages }) => (
  <Field model={model}>
    {(props) => (
      <div className={inputContainerClassName(props)}>
        <Control
          id={id}
          model={model}
          label={label}
          onBlur={onBlur}
          validators={validators}
          component={MaterialCountryInput}
        />

        {needToShowErrors(props) &&
          <Errors
            wrapper={ErrorWrapper}
            messages={messages}
            component="div"
            model={model}
          />
        }
      </div>
    )}
  </Field>
)

MaterialCountryInputWrapper.propTypes = {
  model: PropTypes.string.isRequired,
  label: PropTypes.string,
  id: PropTypes.string,

  validators: PropTypes.object,
  messages: PropTypes.object,

  onBlur: PropTypes.func
}

MaterialCountryInputWrapper.defaultProps = {
  label: 'Country'
}

export default MaterialCountryInputWrapper
