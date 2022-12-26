import React from 'react'
import { StepGroup, Step } from '@components/Step'
import DesignerPortfolioForm from '../../containers/signup/DesignerPortfolioForm'

const Header = () => (
  <div className="main-subheader">
    <div className="container">
      <h1 className="main-subheader__title">
        Upload your portfolio for vetting
      </h1>

      <StepGroup currentStep={2}>
        <Step index={1} title="Registration" completed />
        <Step index={2} title="Profile data" completed />
        <Step index={3} title="Portfolio" active />
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
          Please upload 4 examples of your best work
          per category that you would like to design in.

          <br />

          Your portfolio will be vetted by our team and you
          will receive an answer by email as soon as we can.
          This can take some time; we get a lot of good portfolios.
          Please bear with us in the meantime!
        </p>
      </div>
    </div>
  </div>
)

const SignupDesignerPortfolioStep = () => (
  <main>
    <Header />

    <div className="join-upload-portfolio container">
      <Hint />

      <DesignerPortfolioForm />
    </div>
  </main>
)

export default SignupDesignerPortfolioStep
