import _ from 'lodash'
import React, { useEffect, useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'
import classNames from 'classnames'
import Dinero from 'dinero.js'

//styles
import styles from './CheckoutStep.module.scss'

//components
import Spinner from '../../components/Spinner'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import Input from '../../components/Input'
import Select from '../../components/Select'
import SummaryItem from '../../components/Summary/SummaryItem'
import SavingsAmount from '../../components/Summary/SavingsAmount'
import { Total } from '../../components/Summary/Total'
import { MoneyBackGuarantee } from '../../components/Summary/MoneyBackGuarantee'
import { PaymentMethod } from '../../components/Summary/PaymentMethod'
import { Testimonial } from '../../components/Summary/Testimonial'
import Discount from '../../components/Discount'

import { updateProject, submitCheckoutStep } from '../../actions/newProjectBuilder'
import { loadProducts } from '../../actions/products'
import { loadNdaPrices } from '../../actions/ndaPrices'
import { loadVatRates } from '../../actions/vatRates'
import { loadDiscount } from '../../actions/discounts'

import { projectSelector } from '@selectors/newProjectBuilder'
import { ndaPricesLoadInProgressSelector, ndaPriceSelector } from '../../selectors/ndaPrices'
import { vatRatesLoadInProgressSelector, vatRatesCountriesSelector, vatRateSelector, isIreland } from '../../selectors/vatRates'
import { productSelector, productByKeySelector, productsLoadInProgressSelector, additionalDesignPriceSelector } from '../../selectors/products'
import { discountAmountSelector } from '../../selectors/discount'
import { meSelector } from '@selectors/me'

import { blindProjectPrice, topDesignersPrice } from '@constants/prices'
import { countriesList } from '@constants'

const getPackName = (spotsCount) => {
  switch(spotsCount) {
  case 0:
    return 'Starter'
  case 5:
    return 'Business'
  case 10:
    return 'Pro'
  default:
    return ''
  }
}

const Checkout = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  useEffect(() => {
    dispatch(loadProducts())
    dispatch(loadNdaPrices())
    dispatch(loadVatRates())
  }, [])

  const ndaPricesLoadInProgress = useSelector(ndaPricesLoadInProgressSelector)
  const productsLoadInProgress = useSelector(productsLoadInProgressSelector)
  const vatRatesLoadInProgress = useSelector(vatRatesLoadInProgressSelector)

  const inProgress = ndaPricesLoadInProgress || productsLoadInProgress || vatRatesLoadInProgress

  const me = useSelector(meSelector)
  const project = useSelector(projectSelector)

  const [firstName, setFirstName] = useState(me.firstName || '')
  const [lastName, setLastName] = useState(me.lastName || '')
  const [firstNameError, setFirstNameError] = useState(null)
  const [lastNameError, setLastNameError] = useState(null)

  const [countryCode, setCountryCode] = useState(me.countryCode || '')
  const [countryCodeError, setCountryCodeError] = useState(null)

  const [companyName, setCompanyName] = useState(me.companyName || '')
  const [vat, setVat] = useState(me.vat || '')
  const [discountCode, setDiscountCode] = useState(project.discountCode || '')

  useEffect(() => {
    dispatch(loadDiscount(discountCode))
  }, [])

  const getProject = (newValues) => {
    return {
      firstName,
      lastName,
      countryCode,
      companyName,
      vat,
      ...newValues
    }
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleFirstNameChange = (event) => {
    setFirstName(event.target.value)

    setFirstNameError(event.target.value ? null : 'Required')

    delayedUpdateProject(getProject({ [event.target.name]: event.target.value }))
  }

  const handleLastNameChange = (event) => {
    setLastName(event.target.value)

    setLastNameError(event.target.value ? null : 'Required')

    delayedUpdateProject(getProject({ [event.target.name]: event.target.value }))
  }

  const handleCountryCodeChange = (event, { value }) => {
    setCountryCode(value)

    setCountryCodeError(value ? null : 'Required')

    delayedUpdateProject(getProject({ countryCode: value }))
  }

  const handleCompanyNameChange = (event) => {
    setCompanyName(event.target.value)
    delayedUpdateProject(getProject({ [event.target.name]: event.target.value }))
  }

  const handleVatChange = (event) => {
    setVat(event.target.value)
    delayedUpdateProject(getProject({ [event.target.name]: event.target.value }))
  }

  const handleDiscountCodeChange = (event) => {
    setDiscountCode(event.target.value)
    delayedUpdateProject(getProject({ [event.target.name]: event.target.value }))
    dispatch(loadDiscount(event.target.value))
  }

  const handleSubmit = async (event) => {
    event.preventDefault()

    dispatch(submitCheckoutStep(projectId, getProject(), step))
  }

  const validate = () => {
    if (!firstName) {
      setFirstNameError('Required')
    }

    if (!lastName) {
      setLastNameError('Required')
    }

    if (!countryCode) {
      setCountryCodeError('Required')
    }
  }

  const product = useSelector(productSelector)
  const vatRatesCountries = useSelector(vatRatesCountriesSelector)
  const brandIdentityProduct = useSelector((state) => productByKeySelector(state, 'brand-identity'))
  const brandIdentityProductPrice = _.get(brandIdentityProduct, ['price', 'cents'], 0)

  const additionalDesignPrice = useSelector((state) => additionalDesignPriceSelector(state, project.maxSpotsCount))
  const ndaPrice = useSelector((state) => ndaPriceSelector(state, project.ndaType))

  const additionalDesignPriceValue = Dinero({ amount: additionalDesignPrice })
  const ndaPriceValue = Dinero({ amount: ndaPrice })

  const brandIdentityUpgradePrice = Dinero({ amount: brandIdentityProductPrice - product.price.cents })
  let totalPrice = Dinero({ amount: (product.price.cents + ndaPrice ) }).add(additionalDesignPriceValue)

  if (project.upgradePackage) {
    totalPrice = totalPrice.add(brandIdentityUpgradePrice)
  }

  const discountAmount = useSelector((state) => discountAmountSelector(state, totalPrice))

  const isVatVisible = companyName && vatRatesCountries && vatRatesCountries.includes(countryCode)

  totalPrice = totalPrice.subtract(discountAmount)

  const vatRate = useSelector((state) => vatRateSelector(state, countryCode))

  const vatAmount = totalPrice.multiply((isIreland(countryCode) || !vat ? vatRate : 0) / 100)

  totalPrice = totalPrice.add(vatAmount)

  const isValid = firstName && lastName && countryCode

  const packName = getPackName(project.maxSpotsCount)

  return inProgress ? (<Spinner />) : (
    <>
      <form className={styles.checkout} onSubmit={handleSubmit}>
        <div className={classNames(styles.billing)}>
          <h1 className={styles.heading}>Checkout</h1>
          <div className={styles.details}>
            <p className={styles.detailsHeader}>Billing address</p>
            <div className="row">
              <div className="col-xs-6">
                <Input
                  inputClassName={styles.input}
                  name="firstName"
                  value={firstName}
                  onChange={handleFirstNameChange}
                  placeholder="First name"
                  error={firstNameError}
                />
              </div>

              <div className="col-xs-6">
                <Input
                  inputClassName={styles.input}
                  name="lastName"
                  value={lastName}
                  onChange={handleLastNameChange}
                  placeholder="Last Name"
                  error={lastNameError}
                />
              </div>
            </div>

            <Select
              name="countryCode"
              value={countryCode}
              options={countriesList}
              placeholder="Country"
              onChange={handleCountryCodeChange}
              error={countryCodeError}
            />

            <Input
              inputClassName={styles.input}
              name="companyName"
              value={companyName}
              placeholder="Company name (optional)"
              onChange={handleCompanyNameChange}
            />

            {isVatVisible && (
              <Input
                inputClassName={styles.input}
                name="vat"
                value={vat}
                placeholder="VAT number (optional)"
                onChange={handleVatChange}
              />
            )}
          </div>
        </div>
        <div className={classNames(styles.totals)}>
          <div className={styles.summary}>
            <h2 className={styles.totalsHeading}>Summary</h2>

            <Discount
              discountCode={discountCode}
              onChange={handleDiscountCodeChange}
            />

            <SummaryItem
              isVisible={additionalDesignPriceValue}
              amount={Dinero({ amount: product.price.cents }).add(additionalDesignPriceValue).toFormat('$0,0.00')}
              name={`${packName} ${product.name} Design`}
            />

            <SummaryItem
              isVisible
              amount={Dinero({ amount: topDesignersPrice * 100 }).toFormat('$0,0.00')}
              name="Top designers"
              isFree
            />

            <SummaryItem
              isVisible
              amount={Dinero({ amount: blindProjectPrice * 100 }).toFormat('$0,0.00')}
              name="Blind Project"
              isFree
            />

            <SummaryItem
              isVisible={project.upgradePackage}
              amount={brandIdentityUpgradePrice.toFormat('$0,0.00')}
              name="Upgrade Pack"
            />

            <SummaryItem
              isVisible={!ndaPriceValue.isZero()}
              amount={Dinero({ amount: ndaPrice }).toFormat('$0,0.00')}
              name="Standard NDA"
            />

            <SummaryItem
              isVisible={!discountAmount.isZero()}
              amount={discountAmount.toFormat('$0,0.00')}
              name="Discount"
            />

            <SummaryItem
              isVisible={!vatAmount.isZero()}
              amount={vatAmount.toFormat('$0,0.00')}
              name="VAT"
            />

            <SavingsAmount
              amount={Dinero({ amount: (topDesignersPrice + blindProjectPrice) * 100 }).add(discountAmount).toFormat('$0,0.00')}
            />
          </div>

          <Total price={totalPrice.toFormat('$0,0.00')} />

          <MoneyBackGuarantee />
          <PaymentMethod />
        </div>
        <Footer
          backButton={<BackButton />}
          continueButton={
            <ContinueButton
              isValid={isValid}
              validate={validate}
              popupContent="Please&nbsp;fill&nbsp;in&nbsp;the&nbsp;required&nbsp;fields&nbsp;before being&nbsp;able&nbsp;to&nbsp;pay&nbsp;&&nbsp;start"
            >Pay now & start →
            </ContinueButton>
          }
        />
      </form>
    </>
  )
}

export default Checkout
