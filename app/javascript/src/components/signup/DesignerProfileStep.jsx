import React from 'react'
import { StepGroup, Step } from '@components/Step'
import DesignerProfileForm from '../../containers/signup/DesignerProfileForm'

const Header = () => (
  <div className="main-subheader">
    <div className="container">
      <h1 className="main-subheader__title">
        Welcome to DesignBro! It’s great to see you here!
      </h1>

      <StepGroup currentStep={1}>
        <Step index={1} title="Registration" completed />
        <Step index={2} title="Profile data" active />
        <Step index={3} title="Portfolio" />
      </StepGroup>
    </div>
  </div>
)

const Hint = () => (
  <div className="row">
    <div className="col-lg-7">
      <div className="main-hint in-grey-400 m-b-20">
        <i className="main-hint__icon icon-info-circle" />
        <p className="main-hint__text in-grey-200">
          Let’s get things going: just fill in your profile.
          <br />
          You will be able to enter competitions as soon as it gets approved!
        </p>
      </div>
    </div>
  </div>
)

const SignupDesignerProfileStep = () => (
  <main>
    <Header />
    <div className="join-profile-info container">
      <Hint />
      <DesignerProfileForm />
    </div>
  </main>
)

export default SignupDesignerProfileStep
