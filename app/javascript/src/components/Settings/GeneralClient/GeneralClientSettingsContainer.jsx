import React, { Component } from 'react'
import { connect } from 'react-redux'
import { actions } from 'react-redux-form'
import countries from 'country-list'

import cloneDeep from 'lodash/cloneDeep'

import { update } from '@actions/client'
import { open } from '@actions/simpleModal'

import showServerErrors from '@utils/errors'
import { sanitizeAttributes } from '@utils/form'

import { getMe } from '@reducers/me'

import GeneralClientSettings from './GeneralClientSettings'

class Container extends Component {
  componentWillMount () {
    const { me, mergeSettingsForm } = this.props
    const form = sanitizeAttributes(me)
    if (form.countryCode) {
      form.country = countries.getName(form.countryCode)
    }

    mergeSettingsForm(form)
  }

  render () {
    return <GeneralClientSettings {...this.props} />
  }
}

const mapStateToProps = (state) => ({
  me: getMe(state)
})

const onSubmit = (clientForm) => {
  const client = cloneDeep(clientForm)
  client.countryCode = countries.getCode(client.country)

  return update(client.id, client)
}

export default connect(mapStateToProps, {
  onSubmit,
  mergeSettingsForm: (form) => actions.merge('forms.clientSettingsGeneral', form),
  onSuccess: () => open({ title: 'Settings', message: 'Excellent, your settings were successfully updated!' }),
  onError: showServerErrors('forms.clientSettingsGeneral')
})(Container)
