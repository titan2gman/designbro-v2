import _ from 'lodash'

export const transformServerErrors = (response) => {
  const errors = response && response.data && response.data.errors

  if (errors) {
    return _.mapKeys(errors, (v, k) => _.camelCase(k))
  }
}
