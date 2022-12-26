import React from 'react'
import { Form } from 'react-redux-form'

import MaterialInput from '@components/inputs/MaterialInput'
import MaterialRadio from '@components/inputs/MaterialRadio'
import MaterialCountryInput from '@components/inputs/MaterialCountryInput'

import { normalizePhone } from '@utils/form'
import { required, countryName, isEmail } from '@utils/validators'

const DesignerPayoutForm = ({
  me,
  values,
  onSubmit,
  onError,
  onSuccess,
  onClose,
  bankTransfer,
  onCountryChange
}) => (
  <Form
    model="forms.requestPayout"
    onSubmit={(v) => {
      onSubmit(v).then((fsa) => fsa.error ? onError(fsa) : onSuccess(fsa))
      onClose()
    }}
  >
    <div className="modal-primary__body">
      <div className="modal-primary__body-block">
        <p className="earn-text-like-label">Amount</p>
        <p className="m-b-0">$ {me.availableForPayout}</p>

        <MaterialCountryInput
          model=".country"
          onChange={onCountryChange}
          validators={{ required, countryName }}
          messages={{ required: 'Required.', countryName: 'Invalid.' }}
        />

        <p className="earn-modal-primary__subtitle modal-primary__subtitle">Select payout method</p>

        <div className="earn-radiobtns">
          <div className="earn-radio">
            <MaterialRadio
              model=".payoutMethod"
              id="paypal"
              name="payout-method"
              autoComplete="payMethod"
              validators={{ required }}
              errors={{ required: 'Required' }}
              value="paypal"
              updateOn="change"
              label="Paypal"
            />
          </div>
          <div className="earn-radio">
            <MaterialRadio
              model=".payoutMethod"
              id="bank-transfer"
              name="payout-method"
              autoComplete="payMethod"
              validators={{ required }}
              errors={{ required: 'Required' }}
              value="bank_transfer"
              updateOn="change"
              label="Bank transfer"
              disabled={!bankTransfer}
            />
            {!bankTransfer &&
              <p className="earn-radio__hint in-pink-600">Not available for your country</p>
            }
          </div>

        </div>
      </div>

      {values.payoutMethod && values.country && <div className="modal-primary__body-block">

        {values.payoutMethod === 'paypal' && <MaterialInput
          model=".paypalEmail"
          label="PayPal Email"
          id="displayName"
          type="text"
          name="paypal-email"
          autoComplete="paypal-email"
          validators={{ isEmail }}
          errors={{ isEmail: 'Please enter a valid email address' }}
        />}

        { values.payoutMethod === 'bank_transfer' && <span>
          <MaterialInput
            model=".iban"
            label="Bank Account Number (IBAN)"
            id="displayName"
            type="text"
            name="bank-acc-number"
            autoComplete="bank-acc-number"
            validators={{ required }}
            errors={{ required: 'Required' }}
          />

          <MaterialInput
            model=".swift"
            label="SWIFT/BIC code"
            id="displayName"
            type="text"
            name="swift-bic-code"
            autoComplete="swift-bic-code"
            validators={{ required }}
            errors={{ required: 'Required' }}
          />
        </span>}

        <div className="row">
          <div className="col-sm-6">
            <MaterialInput
              model=".firstName"
              label="First Name"
              id="displayName"
              type="text"
              name="first-name"
              autoComplete="first-name"
              validators={{ required }}
              errors={{ required: 'Required' }}
            />
          </div>

          <div className="col-sm-6">
            <MaterialInput
              model=".lastName"
              label="Last Name"
              id="displayName"
              type="text"
              name="last-name"
              autoComplete="last-name"
              validators={{ required }}
              errors={{ required: 'Required' }}
            />
          </div>
        </div>

        <MaterialInput
          model=".address1"
          label="Address 1"
          id="displayName"
          type="text"
          name="address1"
          autoComplete="adress1"
          validators={{ required }}
          errors={{ required: 'Required' }}
        />

        <MaterialInput
          model=".address2"
          label="Address 2 (opt.)"
          id="displayName"
          type="text"
          name="adress"
          autoComplete="adress2"
        />

        <div className="row">
          <div className="col-sm-6">
            <MaterialInput
              model=".city"
              label="City"
              id="displayName"
              type="text"
              name="city"
              autoComplete="city"
              validators={{ required }}
              errors={{ required: 'Required' }}
            />
          </div>
          <div className="col-sm-6">
            <p className="earn-text-like-label">Country</p>
            <p className="m-b-0">{values.country}</p>
          </div>
        </div>

        <MaterialInput
          model=".state"
          label="State (opt.)"
          id="displayName"
          type="text"
          name="state"
          autoComplete="state1"
        />

        { values.payoutMethod === 'paypal' && <MaterialInput
          model=".phone"
          label="Phone number (opt.)"
          id="displayName"
          type="text"
          name="number"
          autoComplete="phone-number"
          parser={normalizePhone}
        /> }

        { values.payoutMethod === 'bank_transfer' && <MaterialInput
          model=".phone"
          label="Phone number"
          id="displayName"
          type="text"
          name="number"
          autoComplete="phone-number"
          validators={{ required }}
          errors={{ required: 'Required' }}
          parser={normalizePhone}
        /> }

      </div> }

      <div className="modal-primary__actions flex-end">
        <button type="submit" className="main-button-link main-button-link--lg main-button-link--grey-black m-b-10">
          Send Request
          <i className="m-l-20 font-8 icon-arrow-right-long" />
        </button>
      </div>
    </div>
  </Form>
)

export default DesignerPayoutForm
