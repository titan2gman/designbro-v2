import unset from 'lodash/unset'
import isNil from 'lodash/isNil'
import pickBy from 'lodash/pickBy'
import mapKeys from 'lodash/mapKeys'
import mapValues from 'lodash/mapValues'
import camelCase from 'lodash/camelCase'
import countries from 'country-list'

import { actions } from 'react-redux-form'

const isPresent = (value) => !isNil(value)
const toString = (value) => value.toString()

export const sanitizeAttributes = (attributes) => (
  mapValues(pickBy(attributes, isPresent), toString)
)

export const extractAttributes = ({ payload }) => (
  sanitizeAttributes(payload.data.attributes)
)

export const extractAttributesWithId = (fsa) => {
  const attributes = extractAttributes(fsa)
  return { id: fsa.payload.data.id, ...attributes }
}

export const showServerErrors = (form) => (fsa) => {
  const errors = fsa.payload.data.errors

  if (errors instanceof Array) {
    return [
      actions.setSubmitFailed(form),
      actions.setErrors(form, { '': errors[0] })
    ]
  } else {
    unset(errors, 'full_messages')
    const e = mapKeys(errors, (_, k) => camelCase(k))
    return [
      actions.setSubmitFailed(form),
      actions.setFieldsErrors(form, e)
    ]
  }
}

export const normalizePhone = (value) => {
  if (!value) {
    return value
  }

  const onlyNums = value.replace(/[^\d]/g, '')

  if (value.slice(0, 1) === '+') {
    return `+${onlyNums.slice(0, 12)}`
  } else {
    return onlyNums.slice(0, 10)
  }
}

export const convertStringsToBooleans = (form) => (
  mapValues(form, (value) => {
    if (value === 'yes') return true
    if (value === 'no') return false

    return value
  })
)

export const replaceCountryNameWithCountryCode = ({ country, ...rest }) => (
  { ...rest, countryCode: countries.getCode(country) }
)

export const replaceCountryCodeWithCountryName = ({ countryCode, ...rest }) => (
  { ...rest, country: countries.getName(countryCode || '') }
)
