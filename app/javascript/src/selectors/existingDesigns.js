export const getExistingDesigns = (state) => state.existingDesigns.ids.map((id) =>
  state.entities.existingDesigns[id]
)
