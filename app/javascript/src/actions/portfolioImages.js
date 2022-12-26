import api from '@utils/api'

const loadPortfolioImages = (listType = 'summary') => api.get({
  endpoint: `/api/v1/portfolio_images?portfolio_list[list_type]=${listType}`,
  normalize: true,

  types: [
    'LOAD_PORTFOLIO_IMAGES_REQUEST',
    'LOAD_PORTFOLIO_IMAGES_SUCCESS',
    'LOAD_PORTFOLIO_IMAGES_FAILURE'
  ]
})

export { loadPortfolioImages }
