import _ from 'lodash'

export const getMyProjectsIds = (state) => state.myProjects.ids

export const getMyProjects = (state) => (
  state.myProjects.ids.map((id) =>
    state.entities.projects[id]
  )
)

export const canDiscoverProjects = (state) => _.some(
  state.designer.profileAttributes.experiences, (e) => {
    return e.state === 'approved'
  }
)
