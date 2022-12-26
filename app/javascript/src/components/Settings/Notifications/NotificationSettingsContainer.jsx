import omitBy from 'lodash/omitBy'

import React, { Component } from 'react'

import { connect } from 'react-redux'
import { actions } from 'react-redux-form'

import { update } from '@actions/user'
import { open } from '@actions/simpleModal'

import showServerErrors from '@utils/errors'

import { getMe } from '@reducers/me'

import NotificationSettings from './NotificationSettings'

class NotificationSettingsContainer extends Component {
  componentWillMount () {
    this.props.restoreForm(
      this.props.me
    )
  }

  render () {
    return <NotificationSettings {...this.props} />
  }
}

const restoreForm = (values) => actions.merge(
  'forms.settingsNotifications', values
)

const mapStateToProps = (state) => ({
  me: omitBy(getMe(state), (value) => (
    value === null
  ))
})

const onSubmit = ({ id, ...values }) => update(id, values)

const onSuccess = () => open({
  title: 'Settings',
  message: 'Excellent, your settings were successfully updated!'
})

const onError = () => showServerErrors('forms.settingsNotifications')

const mapDispatchToProps = {
  onError,
  onSubmit,
  onSuccess,
  restoreForm
}

export default connect(mapStateToProps, mapDispatchToProps)(
  NotificationSettingsContainer
)
