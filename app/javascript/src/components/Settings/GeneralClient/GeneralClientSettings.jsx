import React from 'react'
import { Form } from 'react-redux-form'

import { required, isEmail, countryName } from '@utils/validators'
import { normalizePhone } from '@utils/form'

import MaterialInput from '@components/inputs/MaterialInput'
import MaterialCountryInput from '@components/inputs/MaterialCountryInput'

export default ({ onSubmit, onError, onSuccess }) => (
  <div className="row">
    <div className="col-lg-5">
      <Form
        model="forms.clientSettingsGeneral"
        onSubmit={(v) => onSubmit(v).then((fsa) => fsa.error ? onError(fsa) : onSuccess(fsa))}
      >
        <div className="settings__group">
          <MaterialInput
            model=".email"
            label="Email"
            id="email"
            type="email"
            name="email"
            autoComplete="email"
            validators={{ required, isEmail }}
            errors={{ required: 'Required', isEmail: 'Doesn\'t look like email' }}
          />
        </div>
        <div className="m-b-30">
          <h2 className="settings__title-secondary">Contact Information</h2>
          <p className="settings__text">Will be used as default billing address</p>
        </div>
        <div className="settings__group">
          <div className="row">
            <div className="col-sm-6">
              <MaterialInput
                model=".firstName"
                label="First Name"
                id="fname"
                type="text"
                name="fname"
                autoComplete="given-name"
                validators={{ required }}
                errors={{ required: 'Required' }}
              />
            </div>
            <div className="col-sm-6">
              <MaterialInput
                model=".lastName"
                label="Last Name"
                id="lname"
                type="text"
                name="lname"
                autoComplete="family-name"
                validators={{ required }}
                errors={{ required: 'Required' }}
              />
            </div>
          </div>

          <MaterialInput
            model=".address1"
            label="Address 1"
            id="addr1"
            type="text"
            name="address"
            autoComplete="address-line1"
            validators={{ required }}
            errors={{ required: 'Required' }}
          />

          <MaterialInput
            model=".address2"
            label="Address 2 (opt.)"
            id="addr2"
            type="text"
            name="address"
            autoComplete="address-line2"
          />

          <MaterialInput
            model=".city"
            label="City"
            id="city"
            type="text"
            name="city"
            autoComplete="address-level2"
            validators={{ required }}
            errors={{ required: 'Required' }}
          />

          <MaterialCountryInput
            id="country"
            model=".country"
            label="Country"
            type="text"
            name="country"
            autoComplete="country"
            validators={{ required, countryName }}
            messages={{ required: 'Required.', countryName: 'Invalid.' }}
          />

          <div className="row">
            <div className="col-sm-6">
              <MaterialInput
                model=".stateName"
                label="State (opt.)"
                id="state"
                type="text"
                name="state"
                autoComplete="address-level1"
              />
            </div>
            <div className="col-sm-6">
              <MaterialInput
                model=".zip"
                label="Zip (opt.)"
                id="zip"
                type="text"
                name="zip"
                autoComplete="postal-code"
              />
            </div>
          </div>
          <MaterialInput
            model=".phone"
            label="Phone number (opt.)"
            id="phone"
            type="text"
            name="mobile"
            autoComplete="tel"
            parser={normalizePhone}
          />

          <MaterialInput
            model=".vat"
            label="VAT number (opt.)"
            id="vat"
            type="text"
            name="vat"
          />
        </div>
        <button className="main-button main-button--lg font-16 main-button--pink-black m-b-30" type="submit">
          Save Changes
          <i className="icon-arrow-right-long align-middle m-l-20 font-8" />
        </button>
      </Form>
    </div>
  </div>
)
