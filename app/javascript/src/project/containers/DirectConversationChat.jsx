import { compose } from 'redux'
import { connect } from 'react-redux'
import sortBy from 'lodash/sortBy'
import _ from 'lodash'
import { withSpinner } from '@components/withSpinner'

import { getMessages } from '@reducers/directConversation'
import { getProject } from '@reducers/projects'
import { getDesign } from '@reducers/designs'
import { getMe } from '@reducers/me'

import DirectConversationChat from '@project/components/DirectConversationChat'
import { getProjectCreator } from '@selectors/projects'

const userLink = (userType, project) => {
  switch (userType) {
  case 'designer':
    return project.state === 'stationery' ? `/d/projects/${project.id}` : `/d/projects/${project.id}/designs`
  case 'client':
    return `/c/projects/${project.id}`
  default:
    return null
  }
}

const mapStateToProps = (state) => {
  const project = getProject(state)
  const client = getProjectCreator(state)
  const design = getDesign(state)
  const inProgress = !project || !design
  const me = getMe(state)

  let messages = getMessages(state)

  messages = _.map(messages, function(message) {
    return me.userId === message.userId ? { ...message, type: 'sent' } : { ...message, type: 'received' }
  })

  if (inProgress) {
    return {
      inProgress
    }
  }

  return {
    inProgress,
    project,
    client,
    design,
    messages: sortBy(messages, 'createdAt'),
    closeLink: userLink(me.userType, project),
    user: me
  }
}

export default compose(
  connect(mapStateToProps),
  withSpinner,
)(DirectConversationChat)
