import { combineForms } from 'react-redux-form'

import times from 'lodash/times'

const signup = {
  displayName: '',
  email: '',
  password: '',
  agreement: false
}

const signin = {
  email: '',
  password: ''
}

const signupConfirmation = {
  email: ''
}

const restorePassword = {
  email: ''
}

const changePassword = {
  currentPassword: '',
  password: ''
}

const designerSettingsGeneral = {
  email: '',
  displayName: '',
  firstName: '',
  lastName: '',
  age: '',
  gender: undefined,
  address1: '',
  address2: '',
  city: '',
  country: '',
  stateName: '',
  zip: '',
  phone: ''
}

const feedback = {
  name: '',
  email: '',
  subject: '',
  message: ''
}

const designerSettingsExperience = {
  experienceBrand: undefined,
  experiencePackaging: undefined,
  experienceEnglish: undefined,
  brandIdentity: times(4, (index) => ({ index, workType: 'brand_identity' })),
  packaging: times(4, (index) => ({ index, workType: 'packaging' }))
}

const clientSettingsGeneral = {
  email: '',
  firstName: '',
  lastName: '',
  address1: '',
  address2: '',
  city: '',
  country: '',
  countryCode: '',
  stateName: '',
  zip: '',
  phone: '',
  vat: ''
}

const settingsNotifications = {
  notifyNews: false,
  notifyProjectsUpdates: false,
  notifyMessagesReceived: false,

  informOnEmail: 'once a day'
}

const comingSoon = {
  email: ''
}

const requestPayout = {
  iban: '',
  city: '',
  swift: '',
  phone: '',
  state: '',
  country: '',
  lastName: '',
  address1: '',
  address2: '',
  firstName: '',
  paypalEmail: '',
  payoutMethod: ''
}

const faqSearch = {
  keywords: ''
}

const newProjectExamplesStepParams = {}

const newProjectPackagingType = {
  packagingType: '',
  bottleMeasurements: {
    technicalDrawingId: '',
    technicalDrawingUrl: '',
    labelHeight: '',
    labelWidth: ''
  },
  canMeasurements: {
    technicalDrawingId: '',
    technicalDrawingUrl: '',
    diameter: '',
    height: '',
    volume: ''
  },
  cardBoxMeasurements: {
    technicalDrawingId: '',
    technicalDrawingUrl: '',
    frontHeight: '',
    frontWidth: '',
    sideDepth: ''
  },
  labelMeasurements: {
    technicalDrawingId: '',
    technicalDrawingUrl: '',
    labelHeight: '',
    labelWidth: ''
  },
  pouchMeasurements: {
    technicalDrawingId: '',
    technicalDrawingUrl: '',
    height: '',
    width: ''
  },
  plasticPackMeasurements: {
    technicalDrawingId: '',
    technicalDrawingUrl: ''
  }
}

const directConversation = {
  text: ''
}

const review = {
  designerRating: 0,
  designerComment: '',
  overallRating: 0,
  overallComment: ''
}

const sourceFiles = {
  no_stock_images: false,
  no_fonts: false,
  both_versions: false,
  i_am_author: false,
  transfer_the_copyright: false
}

const stubs = {}

export default combineForms({
  stubs,
  review,
  signup,
  signin,
  feedback,
  faqSearch,
  comingSoon,
  sourceFiles,
  requestPayout,
  changePassword,
  restorePassword,
  directConversation,
  signupConfirmation,
  clientSettingsGeneral,
  settingsNotifications,
  designerSettingsGeneral,
  newProjectPackagingType,
  designerSettingsExperience,
  newProjectExamplesStepParams,
}, 'forms')
