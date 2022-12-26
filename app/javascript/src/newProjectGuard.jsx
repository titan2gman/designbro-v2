import React from 'react'
import { compose } from 'redux'
import { withRouter, Redirect } from 'react-router-dom'
import { connect } from 'react-redux'
import { getProjectBuilderPath } from './utils/projectFinishPathHelper'

const restrictedPathsForFinishedStates = [
  '/projects/:id/inspirations',
  '/projects/:id/packaging',
  '/projects/:id/style',
  '/projects/:id/audience',
  '/projects/:id/finish',
  '/c/projects/:id/details',
  '/c/projects/:id/checkout',
  '/c/projects/:id/success',
  '/c/projects/:id/invoice',
  '/c/projects/:id/stationery'
]

const restrictedPaths = {
  draft: [
    // '/projects/:id/style',
    '/projects/:id/audience',
    '/projects/:id/finish',
    '/c/projects/:id/details',
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/invoice',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_style_details: [
    '/projects/:id/audience',
    '/projects/:id/finish',
    '/c/projects/:id/details',
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/invoice',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_audience_details: [
    '/projects/:id/finish',
    '/c/projects/:id/details',
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/invoice',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_finish_details: [
    '/c/projects/:id/details',
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/invoice',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_details: [
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/invoice',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_checkout: [
    '/c/projects/:id/success',
    '/c/projects/:id/invoice',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_payment: [
    '/projects/:id/inspirations',
    '/projects/:id/packaging',
    '/projects/:id/style',
    '/projects/:id/audience',
    '/projects/:id/finish',
    '/c/projects/:id/details',
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_payment_and_stationery_details: [
    '/projects/:id/inspirations',
    '/projects/:id/packaging',
    '/projects/:id/style',
    '/projects/:id/audience',
    '/projects/:id/finish',
    '/c/projects/:id/details',
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/stationery',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],
  waiting_for_stationery_details: [
    '/projects/:id/inspirations',
    '/projects/:id/packaging',
    '/projects/:id/style',
    '/projects/:id/audience',
    '/projects/:id/finish',
    '/c/projects/:id/details',
    '/c/projects/:id/checkout',
    '/c/projects/:id/success',
    '/c/projects/:id/invoice',

    '/c/projects/:id/brief',
    '/c/projects/:id/files',
    '/c/projects/:id'
  ],

  design_stage: restrictedPathsForFinishedStates,
  finalist_stage: restrictedPathsForFinishedStates,
  files_stage: restrictedPathsForFinishedStates,
  review_files: restrictedPathsForFinishedStates,
  completed: restrictedPathsForFinishedStates,
  canceled: restrictedPathsForFinishedStates,
  error: restrictedPathsForFinishedStates,
  test: restrictedPathsForFinishedStates
}

const redirectPath = (project, location) => {
  if (restrictedPaths[project.state].includes(location)) {
    return getProjectBuilderPath(project)
  }
}

const mapStateToProps = (state) => {
  const projectId = state.projects.current
  const project = state.entities.projects[projectId]

  return {
    project
  }
}

const composedNewProjectGuard = (View) => (props) => {
  if (!props.project) {
    return null
  }

  const redirect = redirectPath(props.project, props.match.path)

  if (redirect) {
    return <Redirect to={redirect} />
  }

  return <View {...props} />
}

export const withNewProjectGuard = compose(
  withRouter,
  connect(mapStateToProps),
  composedNewProjectGuard
)
