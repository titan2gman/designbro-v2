import _ from 'lodash'
import { containsBannedRegexp, isAdult, isValidDate, buildDateOfBirth } from './helpers'
import { isEmail } from '@utils/validators'

export const validateProfile = (state) => {
  const validation = {}

  if (!state.designer.profileAttributes.displayName) {
    validation.displayName = 'Please enter your user name'
  }

  if (!validation.displayName && containsBannedRegexp(state.designer.profileAttributes.displayName, /[.@]/)) {
    validation.displayName = '"." and "@" are not allowed'
  }

  if (!state.designer.profileAttributes.firstName) {
    validation.firstName = 'Required'
  }

  if (!state.designer.profileAttributes.lastName) {
    validation.lastName = 'Required'
  }

  if (!state.designer.profileAttributes.countryCode) {
    validation.countryCode = 'Required'
  }

  if(!state.designer.profileAttributes.dateOfBirthDay) {
    validation.dateOfBirthDay = 'Required'
  }

  if(!state.designer.profileAttributes.dateOfBirthMonth) {
    validation.dateOfBirthMonth = 'Required'
  }

  const dateOfBirth = buildDateOfBirth(state.designer.profileAttributes.dateOfBirthMonth, state.designer.profileAttributes.dateOfBirthDay, state.designer.profileAttributes.dateOfBirthYear)

  if (!state.designer.profileAttributes.dateOfBirthYear) {
    validation.dateOfBirthYear = 'Required'
  } else if (!isValidDate(dateOfBirth)) {
    validation.dateOfBirthYear = 'Not valid date'
  } else if (!isAdult(dateOfBirth)) {
    validation.dateOfBirthYear = 'Sorry, you have to be at least 18 to use DesignBro'
  }

  if (!state.designer.profileAttributes.gender) {
    validation.gender = 'Required'
  }

  if (!state.designer.profileAttributes.experienceEnglish) {
    validation.experienceEnglish = 'Required'
  }

  return validation
}

export const isProfileValid = (validation) => {
  const attributes = [
    'displayName',
    'firstName',
    'lastName',
    'countryCode',
    'dateOfBirthDay',
    'dateOfBirthMonth',
    'dateOfBirthYear',
    'gender',
    'experienceEnglish'
  ]

  return _.every(_.pick(validation, attributes), _.isEmpty)
}

export const validateSettingsProfile = (state) => {
  const validation = {}

  if (!state.designer.profileAttributes.email) {
    validation.email = 'Required'
  } else if (!isEmail(state.designer.profileAttributes.email)) {
    validation.email = 'Not valid email'
  }

  if (!state.designer.profileAttributes.firstName) {
    validation.firstName = 'Required'
  }

  if (!state.designer.profileAttributes.lastName) {
    validation.lastName = 'Required'
  }

  if(!state.designer.profileAttributes.dateOfBirthDay) {
    validation.dateOfBirthDay = 'Required'
  }

  if(!state.designer.profileAttributes.dateOfBirthMonth) {
    validation.dateOfBirthMonth = 'Required'
  }

  const dateOfBirth = buildDateOfBirth(state.designer.profileAttributes.dateOfBirthMonth, state.designer.profileAttributes.dateOfBirthDay, state.designer.profileAttributes.dateOfBirthYear)

  if (!state.designer.profileAttributes.dateOfBirthYear) {
    validation.dateOfBirthYear = 'Required'
  } else if (!isValidDate(dateOfBirth)) {
    validation.dateOfBirthYear = 'Not valid date'
  } else if (!isAdult(dateOfBirth)) {
    validation.dateOfBirthYear = 'Sorry, you have to be at least 18 to use DesignBro'
  }

  if (!state.designer.profileAttributes.gender) {
    validation.gender = 'Required'
  }

  if (!state.designer.profileAttributes.countryCode) {
    validation.countryCode = 'Required'
  }

  if(!state.designer.profileAttributes.city) {
    validation.city = 'Required'
  }

  if(!state.designer.profileAttributes.address1) {
    validation.address1 = 'Required'
  }

  if(!state.designer.profileAttributes.phone) {
    validation.phone = 'Required'
  }

  return validation
}

export const isProfileSettingsValid = (validation) => {
  const attributes = [
    'email',
    'firstName',
    'lastName',
    'countryCode',
    'dateOfBirthDay',
    'dateOfBirthMonth',
    'dateOfBirthYear',
    'gender',
    'city',
    'address1',
    'phone'
  ]

  return _.every(_.pick(validation, attributes), _.isEmpty)
}
