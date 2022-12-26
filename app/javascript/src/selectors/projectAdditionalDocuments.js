export const getAdditionalDocuments = (state) => state.projectAdditionalDocuments.ids.map((id) =>
  state.entities.projectAdditionalDocuments[id]
)
