import _ from 'lodash'
import { createSelector } from 'reselect'

export const getFinalistDesigners = (state) => _.map(state.finalistDesigners.ids, (id) => state.entities.finalistDesigners[id])
