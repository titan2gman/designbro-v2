import React from 'react'

import Row from '@components/inputs/Row'
import MaterialInput from '@components/inputs/MaterialInputPlain'
import MaterialSelect from '@components/inputs/MaterialSelectPlain'
import MaterialCountryInput from '@components/inputs/MaterialCountryInputPlain'

import { normalizePhone } from '@utils/form'
import { genderOptions, monthOfBirthOptions } from '@constants'

const SubmitButton = () => (
  <button className="main-button main-button--lg font-16 main-button--pink-black m-b-30" type="submit">
    Save Changes
    <i className="icon-arrow-right-long align-middle m-l-20 font-8" />
  </button>
)

const DesignerSettingsGeneralForm = ({ open, changeProfileAttribute, errors, attributes, saveProfileSettingsAttributes }) => {

  const handleSubmit = (e) => {
    e.preventDefault()
    saveProfileSettingsAttributes(() => {
      open({ title: 'Settings', message: 'Excellent, your settings were successfully updated!' })
    })
  }

  const handleChangePhoneNumber = (name, value) => {
    changeProfileAttribute(name, normalizePhone(value))
  }

  return (
    <div className="row">
      <form className="col-lg-6" onSubmit={handleSubmit}>
        <div className="settings__group">
          <MaterialInput
            label="Email"
            id="email"
            type="email"
            name="email"
            value={attributes.email}
            error={errors.email}
            onChange={changeProfileAttribute}
          />

          <MaterialInput
            label="Displayed username"
            id="username"
            type="text"
            name="username"
            value={attributes.displayName}
            disabled
          />

          <Row columnClass="col-sm-6">
            <MaterialInput
              label="First Name"
              type="text"
              name="firstName"
              value={attributes.firstName}
              onChange={changeProfileAttribute}
              error={errors.firstName}
            />

            <MaterialInput
              label="Last Name"
              id="lname"
              type="text"
              name="lastName"
              value={attributes.lastName}
              onChange={changeProfileAttribute}
              error={errors.lastName}
            />
          </Row>

          <Row columnClass="col-sm-4">
            <MaterialSelect
              name="dateOfBirthMonth"
              placeholder="Month of Birth"
              options={monthOfBirthOptions}
              value={attributes.dateOfBirthMonth || null}
              onChange={changeProfileAttribute}
              error={errors.dateOfBirthMonth}
            />
            <MaterialInput
              label="Day of Birth"
              name="dateOfBirthDay"
              type="number"
              value={attributes.dateOfBirthDay}
              onChange={changeProfileAttribute}
              error={errors.dateOfBirthDay}
            />
            <MaterialInput
              label="Year of Birth"
              name="dateOfBirthYear"
              type="number"
              value={attributes.dateOfBirthYear}
              onChange={changeProfileAttribute}
              error={errors.dateOfBirthYear}
            />
          </Row>
          <MaterialSelect
            name="gender"
            options={genderOptions}
            value={attributes.gender}
            onChange={changeProfileAttribute}
            error={errors.gender}
            placeholder="Gender"
          />
        </div>

        <div className="settings__group">
          <div className="m-b-30">
            <h2 className="settings__title-secondary">Address details:</h2>
          </div>

          <MaterialInput
            label="Address 1"
            type="text"
            name="address1"
            value={attributes.address1}
            onChange={changeProfileAttribute}
            error={errors.address1}
          />

          <MaterialInput
            label="Address 2 (opt.)"
            type="text"
            name="address2"
            value={attributes.address2}
            onChange={changeProfileAttribute}
            // error={errors.address2}
          />

          <MaterialInput
            label="City"
            type="text"
            name="city"
            value={attributes.city}
            onChange={changeProfileAttribute}
            error={errors.city}
          />

          <MaterialCountryInput
            name="countryCode"
            value={attributes.countryCode}
            onChange={changeProfileAttribute}
            error={errors.countryCode}
          />

          <Row columnClass="col-sm-6">
            <MaterialInput
              label="State (opt.)"
              type="text"
              name="stateName"
              value={attributes.stateName}
              onChange={changeProfileAttribute}
            />

            <MaterialInput
              label="Zip (opt.)"
              type="text"
              name="zip"
              value={attributes.zip}
              onChange={changeProfileAttribute}
            />
          </Row>

          <MaterialInput
            label="Phone number"
            type="text"
            name="phone"
            value={attributes.phone}
            onChange={handleChangePhoneNumber}
            error={errors.phone}
          />
        </div>


        <SubmitButton />
      </form>
    </div>
  )
}


export default DesignerSettingsGeneralForm
