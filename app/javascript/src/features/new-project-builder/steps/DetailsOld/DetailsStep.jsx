import _ from 'lodash'
import React, { useEffect, useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'
import classNames from 'classnames'
import Dinero from 'dinero.js'

//styles
import styles from './DetailsStep.module.scss'

//components
import Spinner from '../../components/Spinner'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import SummaryItem from '../../components/Summary/SummaryItem'
import SavingsAmount from '../../components/Summary/SavingsAmount'
import { TopDesigners } from './components/Features/TopDesigners'
import { BlindProject } from './components/Features/BlindProject'
import { NDA } from './components/Features/NDA'
import { BrandIdentity } from './components/Features/BrandIdentity'
import { DesignersNumber } from './components/Features/DesignersNumber'
import { Total } from '../../components/Summary/Total'
import { MoneyBackGuarantee } from '../../components/Summary/MoneyBackGuarantee'
import { PaymentMethod } from '../../components/Summary/PaymentMethod'
import { Testimonial } from '../../components/Summary/Testimonial'
import Discount from '../../components/Discount'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'
import { loadProducts } from '../../actions/products'
import { loadNdaPrices } from '../../actions/ndaPrices'
import { loadDiscount } from '../../actions/discounts'

import { projectSelector } from '@selectors/newProjectBuilder'
import { ndaPricesLoadInProgressSelector, ndaPriceSelector } from '../../selectors/ndaPrices'
import { productSelector, productByKeySelector, productsLoadInProgressSelector, additionalDesignPriceSelector } from '../../selectors/products'
import { discountAmountSelector } from '../../selectors/discount'
import { isAuthenticatedSelector } from '@selectors/me'

import { blindProjectPrice, topDesignersPrice } from '@constants/prices'

import { showSignUpModal } from '@actions/modal'

const Details = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  useEffect(() => {
    dispatch(loadProducts())
    dispatch(loadNdaPrices())
  }, [])

  const ndaPricesLoadInProgress = useSelector(ndaPricesLoadInProgressSelector)
  const productsLoadInProgress = useSelector(productsLoadInProgressSelector)

  const inProgress = ndaPricesLoadInProgress || productsLoadInProgress

  const isAuthenticated = useSelector(isAuthenticatedSelector)
  const project = useSelector(projectSelector)
  const product = useSelector(productSelector)
  const brandIdentityProduct = useSelector((state) => productByKeySelector(state, 'brand-identity'))
  const brandIdentityProductPrice = _.get(brandIdentityProduct, ['price', 'cents'], 0)

  const [maxSpotsCount, setMaxSpotsCount] = useState(project.maxSpotsCount)
  const [maxScreensCount, setMaxScreensCount] = useState(project.maxScreensCount)
  const [ndaType, setNdaType] = useState(project.ndaType)
  const [upgradePackage, setUpgradePackage] = useState(project.upgradePackage)
  const [discountCode, setDiscountCode] = useState(project.discountCode || '')

  const additionalDesignPrice = useSelector((state) => additionalDesignPriceSelector(state, maxSpotsCount))
  const ndaPrice = useSelector((state) => ndaPriceSelector(state, ndaType))
  const standardNdaPrice = useSelector((state) => ndaPriceSelector(state, 'standard'))

  const getProject = (newValues) => {
    return {
      maxSpotsCount,
      maxScreensCount,
      ndaType,
      upgradePackage,
      discountCode,
      ...newValues
    }
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleMaxSpotsCountChange = (value) => {
    setMaxSpotsCount(value)
    dispatch(updateProject(projectId, getProject({ maxSpotsCount: value }), step))
  }

  const handleNdaChange = () => {
    const value = ndaType === 'standard' ? 'free' : 'standard'
    setNdaType(value)
    dispatch(updateProject(projectId, getProject({ ndaType: value }), step))
  }

  const handleBrandIdentityChange = () => {
    setUpgradePackage(!upgradePackage)
    dispatch(updateProject(projectId, getProject({ upgradePackage: !upgradePackage }), step))
  }

  const handleDiscountCodeChange = (event) => {
    setDiscountCode(event.target.value)
    delayedUpdateProject(getProject({ [event.target.name]: event.target.value }))
    dispatch(loadDiscount(event.target.value))
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    if (isAuthenticated) {
      dispatch(submitUpdateProject(projectId, getProject(), step, true))
    } else {
      dispatch(showSignUpModal({
        successCallback: signUpSuccessCallback
      }))
    }
  }

  const signUpSuccessCallback = () => {
    dispatch(submitUpdateProject(projectId, getProject(), step, true))
  }

  const additionalDesignPriceValue = Dinero({ amount: additionalDesignPrice })
  const ndaPriceValue = Dinero({ amount: ndaPrice })

  const brandIdentityUpgradePrice = Dinero({ amount: brandIdentityProductPrice - product.price.cents })
  let totalPrice = Dinero({ amount: (product.price.cents + ndaPrice ) }).add(additionalDesignPriceValue)

  if (upgradePackage) {
    totalPrice = totalPrice.add(brandIdentityUpgradePrice)
  }

  const discountAmount = useSelector((state) => discountAmountSelector(state, totalPrice))

  totalPrice = totalPrice.subtract(discountAmount)

  return inProgress ? (<Spinner />) : (
    <>
      <form className={styles.details} onSubmit={handleSubmit}>
        <div className={classNames(styles.features)}>
          <h1 className={styles.heading}>Boost your project!</h1>

          <DesignersNumber
            value={maxSpotsCount}
            minCount={3}
            maxCount={10}
            onChange={handleMaxSpotsCountChange}
            price={additionalDesignPriceValue.toFormat('$0,0')}
          />

          <TopDesigners />
          <BlindProject />

          <NDA
            ndaType={ndaType}
            price={`+ ${Dinero({ amount: standardNdaPrice }).toFormat('$0,0')}`}
            onChange={handleNdaChange}
          />

          {/*<BrandIdentity
            value={upgradePackage}
            price={`+ ${brandIdentityUpgradePrice.toFormat('$0,0')}`}
            onChange={handleBrandIdentityChange}
          />*/}
        </div>
        <div className={classNames(styles.totals)}>
          <div className={styles.summary}>
            <h2 className={styles.totalsHeading}>Summary</h2>

            <SummaryItem
              isVisible={additionalDesignPriceValue}
              amount={Dinero({ amount: product.price.cents }).toFormat('$0,0.00')}
              name={`${product.name} Design`}
            />

            <SummaryItem
              isVisible={!additionalDesignPriceValue.isZero()}
              amount={additionalDesignPriceValue.toFormat('$0,0.00')}
              name="Extra designs"
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

            {/*<SummaryItem
              isVisible={upgradePackage}
              amount={brandIdentityUpgradePrice.toFormat('$0,0.00')}
              name="Upgrade Pack"
            />*/}

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

            <SavingsAmount
              amount={Dinero({ amount: (topDesignersPrice + blindProjectPrice) * 100 }).add(discountAmount).toFormat('$0,0.00')}
            />
          </div>

          <Total price={totalPrice.toFormat('$0,0.00')} />

          <Discount
            discountCode={discountCode}
            onChange={handleDiscountCodeChange}
          />

          <MoneyBackGuarantee />
          <PaymentMethod />
          <Testimonial />
        </div>
        <Footer
          backButton={<BackButton />}
          continueButton={
            <ContinueButton isValid={true}>Continue →</ContinueButton>
          }
        />
      </form>
    </>
  )
}

export default Details
