import _ from 'lodash'

export const getCompanyById = (id) => (state) => {
  return _.get(state.entities.companies, id)
}
