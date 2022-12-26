import React from 'react'
import { Form } from 'react-redux-form'
import Checkbox from '@components/inputs/Checkbox'

/* TODO */
/* const inform = [
  { text: 'Instant', value: 'instant' },
  { text: 'Once an hour', value: 'once an hour' },
  { text: 'Once a day', value: 'once a day' },
  { text: 'Never', value: 'never' }
] */

const SettingsNotificationsForm = ({ onSubmit, onError, onSuccess }) => (
  <Form model="forms.settingsNotifications" onSubmit={
    (values) => onSubmit(values).then(
      (fsa) => fsa.error
        ? onError(fsa)
        : onSuccess(fsa)
    )
  }>
    <div className="settings__content container">
      <div className="m-b-45">
        <h2 className="settings__title-secondary">
          Email notifications
        </h2>
      </div>

      <div className="m-b-55">
        <ul>
          <li>
            <Checkbox
              id="projects-updates"
              model=".notifyProjectsUpdates"
              label="Updates with my projects"
            />
          </li>
          <li>
            <Checkbox
              id="messages-received"
              model=".notifyMessagesReceived"
              label="New messages received"
            />
          </li>
          <li>
            <Checkbox
              id="news"
              model=".notifyNews"
              label="News from DesignBro"
            />
          </li>
        </ul>
      </div>
      {/* TODO: */}
      {/* <div className='settings__notifications-group'>
        <div className='m-b-20'>
          <h2 className='settings__title-secondary'>
            When to inform on email
          </h2>
        </div>

        <Control.select
          fluid
          selection
          options={inform}
          id='inform-on-email'
          component={Dropdown}
          model='.informOnEmail'
          className='main-dropdown max-20'
        />
      </div> */}

      <button className="main-button main-button--lg font-16 main-button--pink-black m-b-30" type="submit">
        Save Changes

        <i className="icon-arrow-right-long align-middle m-l-20 font-8" />
      </button>
    </div>
  </Form>
)

export default SettingsNotificationsForm
