import _ from 'lodash'
import moment from 'moment'
import countries from 'country-list'

export const ADDITIONAL_SPOTS_SURCHARGE = 15 // percent
export const ADDITIONAL_DAY_PRICE = 15 // USD
export const MAX_ADDITIONAL_DAYS = 15 // days

export const hostName = 'https://designbro.com'

export const REQUIRED_GOOD_EXAMPLES_COUNT = 3

export const designExperienceOptions = [
  { text: 'No experience', value: 'no_experience' },
  { text: '1-3 years', value: 'junior_experience' },
  { text: '4-7 years', value: 'middle_experience' },
  { text: 'over 8 years', value: 'senior_experience' }
]

export const genderOptions = [
  { text: 'Male', value: 'male' },
  { text: 'Female', value: 'female' },
  { text: 'Prefer not to say', value: 'unknown' }
]

export const englishOptions = [
  { text: 'Not good', value: 'not_good_english' },
  { text: 'Acceptable', value: 'acceptable_english' },
  { text: 'Good', value: 'good_english' },
  { text: 'Native', value: 'native_english' }
]

export const monthOfBirthOptions = moment.months().map((month, index) => {
  return { key: index + 1, text: month, value: index + 1 }
})

export const countriesList = _.sortBy(_.map(countries.getCodeList(), (text, value) => {
  return { value: value.toUpperCase(), text }
}), 'text')

export const products = [
  'logo',
  'brand-identity',
  'packaging',
  'website',
  'website-banner',
  'poster',
  'menu',
  'flyer',
  'billboard',
  'album-cover',
  'magazine-cover',
  'book-cover',
  't-shirt',
  'business-card',
  'instagram-post',
  'facebook',
  'twitter',
  'linkedin',
  'youtube',
  'zoom-background'
]

export const productsWithPdfDeliverable = [
  'logo',
  'brand-identity',
  'packaging',
  'website',
  'website-banner',
  'poster',
  'flyer',
  'instagram-post',
  'facebook',
  'twitter',
  'linkedin',
  'youtube',
  'zoom-background'
]
