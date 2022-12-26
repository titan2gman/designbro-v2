import api from '@utils/api'
import map from 'lodash/map'
import every from 'lodash/every'
import pickBy from 'lodash/pickBy'
import flatten from 'lodash/flatten'

const normalizePortfolioData = (data) => {
  const nonEmpty = pickBy(data, (g) => every(g, 'id'))
  const portfolioWorks = flatten(map(nonEmpty))
  return { portfolioWorks }
}

export const create = (data) =>
  api.post({
    endpoint: '/api/v1/portfolios',
    types: ['PORTFOLIO_CREATE_REQUEST', 'PORTFOLIO_CREATE_SUCCESS', 'PORTFOLIO_CREATE_FAILURE'],
    body: { portfolio: normalizePortfolioData(data) }
  })

export const loadPortfolio = () =>
  api.get({
    endpoint: '/api/v1/portfolios',
    types: ['PORTFOLIO_LOAD_START', 'PORTFOLIO_LOAD_SUCCESS', 'PORTFOLIO_LOAD_FAILURE'],
    normalize: true
  })

export const portfolioUploaded = () => ({ type: 'PORTFOLIO_UPLOADED' })
