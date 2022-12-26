import React, { Component } from 'react'
import { connect } from 'react-redux'
import { actions } from 'react-redux-form'
import { history } from '../../history'
import countries from 'country-list'

import pick from 'lodash/pick'

import { create } from '@actions/payouts'
import { loadVatRates } from '@actions/vatRates'

import clearForm from '@utils/clearForm'
import showServerErrors from '@utils/errors'

import { getMe } from '@reducers/me'
import { isEuropeanCountry } from '@selectors/vat'

import DesignerPayoutsForm from '@designer/components/DesignerPayoutForm'

const isBankTransferAllow = (state, country) => country && isEuropeanCountry(state, countries.getCode(country))

class Container extends Component {
  componentWillMount () {
    this.props.mergeRequestPayoutForm(
      this.props.values
    )

    this.props.loadVatRates()
  }

  handleCountryChange () {
    if (!this.props.bankTransfer &&
    this.props.values.payoutMethod === 'bank transfer') {
      this.props.mergeRequestPayoutForm({ payoutMethod: '' })
    }
  }

  render () {
    return (<DesignerPayoutsForm
      {...this.props}
      onCountryChange={() => this.handleCountryChange()}
    />)
  }
}

const mapStateToProps = (state) => {
  return {
    values: pick(state.forms.requestPayout, ['payoutMethod', 'country']),
    me: getMe(state),
    onSuccess: () => window.alert('success'),
    bankTransfer: isBankTransferAllow(state, state.forms.requestPayout.country)
  }
}

const mapDispatchToProps = {
  mergeRequestPayoutForm: (values) => actions.merge('forms.requestPayout', values),
  onSubmit: create,
  onError: showServerErrors('forms.requestPayout'),
  onSuccess: () => history.push('/d/payouts'),
  loadVatRates
}

const SelfClearingDesignerPayoutFormContainer =
  clearForm('forms.requestPayout')(Container)

export default connect(mapStateToProps, mapDispatchToProps)(SelfClearingDesignerPayoutFormContainer)
