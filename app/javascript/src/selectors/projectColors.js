import isEmpty from 'lodash/isEmpty'
import { getCurrentProject } from './projects'

export const getColors = (state) => state.projectColors.ids.map((id) =>
  state.entities.projectColors[id]
)

export const getNewColors = (state) => {
  const project = getCurrentProject(state)
  return project && project.newColors
}

export const getColorsComment = (state) => {
  const project = getCurrentProject(state)

  return project && project.colorsComment
}

export const isColorsExist = (state) => !isEmpty(getNewColors(state)) || !isEmpty(getColors(state)) || !isEmpty(getColorsComment(state))
