export const getStockImages = (state) => state.projectStockImages.ids.map((id) =>
  state.entities.projectStockImages[id]
)
