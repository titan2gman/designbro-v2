import api from '@utils/apiV2'
import Dinero from 'dinero.js'
import { getFileData } from '@utils/fileUtilities'
import { history } from '../../../history'
import { loadStripe } from '@stripe/stripe-js'
import { saveGACheckoutEvent, saveGAPurchaseEvent } from '@utils/googleAnalytics'
import { productSelector } from '../selectors/products'
import { projectBuilderStepSelector, projectSelector } from '@selectors/newProjectBuilder'

const stripePromise = loadStripe(process.env.STRIPE_PUBLISHABLE_KEY)

export const LOAD_PROJECT_REQUEST = 'new-project-builder/LOAD_PROJECT_REQUEST'
export const LOAD_PROJECT_SUCCESS = 'new-project-builder/LOAD_PROJECT_SUCCESS'
export const LOAD_PROJECT_FAILURE = 'new-project-builder/LOAD_PROJECT_FAILURE'

export const loadProject = (id) => api.get({
  endpoint: `/api/v2/client/projects/${id}`,
  types: [LOAD_PROJECT_REQUEST, LOAD_PROJECT_SUCCESS, LOAD_PROJECT_FAILURE]
})

export const CREATE_PROJECT_REQUEST = 'new-project-builder/CREATE_PROJECT_REQUEST'
export const CREATE_PROJECT_SUCCESS = 'new-project-builder/CREATE_PROJECT_SUCCESS'
export const CREATE_PROJECT_FAILURE = 'new-project-builder/CREATE_PROJECT_FAILURE'

const createProjectApiCall = (project) => api.post({
  endpoint: '/api/v2/client/projects',
  body: { project },
  types: [CREATE_PROJECT_REQUEST, CREATE_PROJECT_SUCCESS, CREATE_PROJECT_FAILURE]
})

const redirectToNextStepCallback = (getState) => () => {
  const state = getState()
  const { id, currentStepPath } = state.newProjectBuilder.project

  history.push(`/new-project/${id}/${currentStepPath}`)

  const project = projectSelector(state)
  const product = productSelector(state)
  const price = Dinero({ amount: project.normalizedPrice || product.price.cents }).toFormat('0,0.00')
  const step = projectBuilderStepSelector(state, currentStepPath)

  saveGACheckoutEvent({
    product,
    price,
    step
  })

  if (!currentStepPath) {
    saveGAPurchaseEvent({
      product,
      id,
      price,
    })
  }

}

export const createContestProject = (project) => (dispatch, getState) => {
  dispatch(createProjectApiCall(project)).then(redirectToNextStepCallback(getState))
}

export const UPDATE_PROJECT_REQUEST = 'new-project-builder/UPDATE_PROJECT_REQUEST'
export const UPDATE_PROJECT_SUCCESS = 'new-project-builder/UPDATE_PROJECT_SUCCESS'
export const UPDATE_PROJECT_FAILURE = 'new-project-builder/UPDATE_PROJECT_FAILURE'

export const updateProject = (id, project, step, upgradeProjectState = false) => api.patch({
  endpoint: `/api/v2/client/projects/${id}`,
  body: { project, step, upgradeProjectState },
  types: [UPDATE_PROJECT_REQUEST, UPDATE_PROJECT_SUCCESS, UPDATE_PROJECT_FAILURE]
})

export const submitUpdateProject = (id, project, step, upgradeProjectState = false) => (dispatch, getState) => {
  dispatch(updateProject(id, project, step, upgradeProjectState)).then(
    redirectToNextStepCallback(getState)
  )
}

export const submitCheckoutStep = (id, project, step) => (dispatch, getState) => {
  dispatch(updateProject(id, project, step, true)).then(() => {
    stripePromise.then((stripe) => {
      const state = getState()
      const { stripeSessionId } = state.newProjectBuilder.project

      stripe.redirectToCheckout({
        sessionId: stripeSessionId,
      })
    })
  })
}

const CREATE_PROJECT_UPLOADED_FILE_REQUEST = 'new-project-builder/CREATE_PROJECT_UPLOADED_FILE_REQUEST'
const CREATE_PROJECT_UPLOADED_FILE_SUCCESS = 'new-project-builder/CREATE_PROJECT_UPLOADED_FILE_SUCCESS'
const CREATE_PROJECT_UPLOADED_FILE_FAILURE = 'new-project-builder/CREATE_PROJECT_UPLOADED_FILE_FAILURE'

export const uploadProjectFile = ({ file, projectId, entity }) => api.post({
  endpoint: `/api/v2/client/uploaded_files?project_id=${projectId}&entity=${entity}`,
  body: getFileData({ file }),

  types: [CREATE_PROJECT_UPLOADED_FILE_REQUEST, CREATE_PROJECT_UPLOADED_FILE_SUCCESS, CREATE_PROJECT_UPLOADED_FILE_FAILURE]
})
