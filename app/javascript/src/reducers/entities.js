import _ from 'lodash'
import merge from 'lodash/merge'
import filter from 'lodash/filter'

import { normalizeEntity } from '@utils/normalizer'

import { REMOVE_PROJECT_FROM_ENTITIES } from '@actions/newProject'

const initialState = {
  project: {},
  designs: {},
  faqItems: {},
  projects: {},
  testimonials: {},
  designerStats: {},
  projectCompetitors: {},
  directConversationMessages: {}
}

const reducer = (state = initialState, action) => {
  switch (action.type) {
  case 'DESIGN_FILE_UPLOAD_SUCCESS':
    const statee = merge({}, state, action.payload.entities)
    const designId = action.payload.results.designs[0]
    const spotId = statee.designs[designId].spot
    const spot = statee.spots[spotId]
    const spotUpdated = _.merge({}, spot, {
      design: designId
    })
    return {
      ...statee,
      spots: {
        ...statee.spots,
        [spotId]: spotUpdated
      }
    }
  case 'DIRECT_CONVERSATION_MESSAGE_RECEIVED':
    return merge({}, state, {
      directConversationMessages: {
        [action.message.id]: action.message
      }
    })

  case 'CLEAN_DIRECT_CONVERSATION_MESSAGES':
    return {
      ...state,
      directConversationMessages: {}
    }

  case 'DESIGNER_STATS_UPDATED': {
    const entity = normalizeEntity(action.designerStats.data)
    return merge({}, state, { designerStats: { [entity.id]: entity } })
  }

  case 'COMPETITOR_LOGO_DESTROY_SUCCESS': {
    const competitors = filter(state.projectCompetitors, (competitor) => competitor.id !== action.payload.data.id)
    return merge({}, state, { projectCompetitors: competitors })
  }

  case 'TESTIMONIAL_LOAD_REQUEST': {
    return {
      ...state,
      testimonials: initialState.testimonials
    }
  }

  case REMOVE_PROJECT_FROM_ENTITIES:
    return {
      ...state,
      projects: _.omit(state.projects, action.id)
    }

  default:
    if (action.payload && action.payload.entities) {
      return merge({}, state, action.payload.entities)
    }

    return state
  }
}

export default reducer
