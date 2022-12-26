import toLower from 'lodash/toLower'
import isEmpty from 'lodash/isEmpty'
import includes from 'lodash/includes'
import countries from 'country-list'

import scorePassword from '@utils/scorePassword'

const countryNames = countries.getNames().map(toLower)

export function isEmail (email) {
  const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  return re.test(email)
}

export function required (val) {
  return val && val.toString().trim().length
}

export function isWeak (value) {
  const score = scorePassword(value)
  return score > 25
}

export function minLength (min) {
  return function (value) {
    return value && value.length >= min
  }
}

export const maxLength = (max) => (value) => (
  value && value.length <= max
)

export function passwordLengthValidator (value) {
  return !(value && value.length) || minLength(6)(value)
}

export function minValue (min) {
  return function (value) {
    return value && Number(value) >= min
  }
}

export function adult (value) {
  return !value || minValue(18)(value)
}

export const countryName = (value) => (
  !value || includes(countryNames, toLower(value))
)

export const tooLongMessage = (value) => (
  !value || maxLength(2000)(value)
)

export const containsNotAllowedRegexp = (regexp) => (value) => (
  isEmpty(value.match(regexp))
)

export const allowedDisplayName = containsNotAllowedRegexp(/[.@]/)
