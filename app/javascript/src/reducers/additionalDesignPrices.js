import values from 'lodash/values'

export const getAdditionalDesignPricesLoaded = (state) => (
  state.additionalDesignPrices.loaded
)

export const getAdditionalDesignPrices = (state) => (
  values(state.entities.additionalDesignPrices)
)

export const getAdditionalDesignPricesByProjectPrice = (state, projectPrice) => (
  getAdditionalDesignPrices(state).filter((additionalDesignPrice) => (
    additionalDesignPrice.projectPrice === projectPrice
  )) || []
)

export const getAdditionalDesignPricesByProjectPriceAndQuantity = (state, projectPrice, quantity) => (
  getAdditionalDesignPricesByProjectPrice(state, projectPrice).find((additionalDesignPrice) => (
    additionalDesignPrice.quantity === quantity
  )) || {}
)
